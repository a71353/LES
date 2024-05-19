from django.shortcuts import get_object_or_404, redirect, render
from inscricoes.models import Inscricao, Inscricaosessao, Responsavel, Inscricaotransporte
from inscricoes.utils import add_vagas_sessao, enviar_mail_confirmacao_inscricao, init_form, nao_tem_permissoes, render_pdf, save_form, update_context, update_post
from atividades.models import Atividade, Sessao, Tema, TemaQ
from atividades.serializers import AtividadeSerializer
from atividades.filters import AtividadeFilter
from inscricoes.forms import AlmocoForm, InfoForm, InscricaoForm, ResponsavelForm, SessoesForm, TransporteForm
from roteiros.models import Roteiro
from utilizadores.models import Administrador, Coordenador, Participante
from questionariosPublicados.models import Resposta, Resposta_Individual
from utilizadores.views import user_check
from django.http import HttpResponseRedirect
from django.urls import reverse
from inscricoes.tables import InscricoesTable
from inscricoes.filters import InscricaoFilter
from django.db.models import Exists, OuterRef
from rest_framework.generics import ListAPIView
from rest_framework.pagination import PageNumberPagination
from formtools.wizard.views import SessionWizardView
from django.views import View
from django_tables2 import SingleTableMixin
from django_filters.rest_framework.backends import DjangoFilterBackend
from rest_framework.filters import OrderingFilter, SearchFilter
from django_filters.views import FilterView
from configuracao.models import Departamento, Diaaberto
from datetime import datetime
import pytz
from configuracao.tests.test_models import create_open_day
from _datetime import timedelta
from django.http import HttpResponse
from django.db.models import Count
import csv
from questionarios.models import Questionario, Pergunta
from collections import defaultdict


def InscricaoPDF(request, pk):
    """ View que gera um PDF com os detalhes da inscrição """
    inscricao = get_object_or_404(Inscricao, pk=pk)
    erro_permissoes = nao_tem_permissoes(request, inscricao)
    if erro_permissoes and not request.user.groups.filter(name="Colaborador").exists():
        return erro_permissoes
    ano = inscricao.diaaberto.ano
    context = {
        'request': request,
        'inscricao': inscricao,
        'ano': ano,
    }
    return render_pdf("inscricoes/pdf.html", context, f"dia_aberto_ualg_{ano}.pdf")


class AtividadesAPI(ListAPIView):
    """ View que gera uma API readonly com as informações das Atividades e das suas sessões
        que vai ser usada para fazer inscrições nas sessões """
    class AtividadesPagination(PageNumberPagination):
        page_size = 10
        page_size_query_param = 'page_size'
        max_page_size = 100

    search_fields = '__all__'
    ordering_fields = '__all__'
    ordering = 'nome'
    filter_backends = (SearchFilter,
                       OrderingFilter, DjangoFilterBackend)
    queryset = Atividade.objects.filter(estado="Aceite")
    serializer_class = AtividadeSerializer
    pagination_class = AtividadesPagination
    filterset_class = AtividadeFilter


class CriarInscricao(SessionWizardView):
    """ View que gera o formulário com passos para criar uma nova inscrição """
    form_list = [
        ('info', InfoForm),
        ('responsaveis', ResponsavelForm),
        ('escola', InscricaoForm),
        ('transporte', TransporteForm),
        ('almoco', AlmocoForm),
        ('sessoes', SessoesForm),
    ]

    def dispatch(self, request, *args, **kwargs):
        _user_check = user_check(request, [Participante])
        if _user_check['exists']:
            participante = _user_check['firstProfile']
            diaaberto = Diaaberto.current()
            if diaaberto is None:
                return redirect('utilizadores:mensagem', 12)
            if datetime.now(pytz.UTC) < diaaberto.datainscricaoatividadesinicio or datetime.now(pytz.UTC) > diaaberto.datainscricaoatividadesfim:
                m = f"Período de abertura das inscrições: {diaaberto.datainscricaoatividadesinicio.strftime('%d/%m/%Y')} até {diaaberto.datainscricaoatividadesfim.strftime('%d/%m/%Y')}"
                return render(request=request,
                              template_name="mensagem.html", context={'m': m, 'tipo': 'error', 'continuar': 'on'})
            self.instance_dict = {
                'responsaveis': Responsavel(nome=f"{participante.first_name} {participante.last_name}", email=participante.email, tel=participante.contacto)
            }
        else:
            return _user_check['render']
        return super(CriarInscricao, self).dispatch(request, *args, **kwargs)

    def get_context_data(self, form, **kwargs):
        context = super().get_context_data(form=form, **kwargs)
        update_context(context, self.steps.current, self)
        if self.steps.current != 'info':
            context.update({
                'individual': self.get_cleaned_data_for_step('info')['individual']
            })
        visited = []
        for step in self.form_list:
            cleaned_data = self.get_cleaned_data_for_step(step)
            if cleaned_data:
                visited.append(True)
            else:
                visited.append(False)
        context.update({
            'visited': visited
        })
        return context

    def get_template_names(self):
        return [f'inscricoes/inscricao_wizard_{self.steps.current}.html']

    def post(self, request, *args, **kwargs):
        # Envia a informação extra necessária para o formulário atual, após preenchê-lo.
        # Necessário para algumas validações especiais de backend, como verificar o número de alunos
        # inscritos para verificar inscritos nos almoços e nas sessões.
        current_step = request.POST.get(
            'criar_inscricao-current_step', self.steps.current)
        update_post(current_step, request.POST, self)
        go_to_step = self.request.POST.get(
            'wizard_goto_step', None)  # get the step name
        if go_to_step is not None:
            form = self.get_form(data=self.request.POST,
                                 files=self.request.FILES)

            if self.get_cleaned_data_for_step(current_step):
                if form.is_valid():
                    self.storage.set_step_data(self.steps.current,
                                               self.process_step(form))
                    self.storage.set_step_files(self.steps.current,
                                                self.process_step_files(form))
                else:
                    return self.render(form)
        return super(CriarInscricao, self).post(*args, **kwargs)

    def done(self, form_list, form_dict, **kwargs):
        # Guardar na Base de Dados
        responsaveis = form_dict['responsaveis'].save(commit=False)
        almoco = form_dict['almoco'].save(commit=False)
        inscricao = form_dict['escola'].save(commit=False)
        inscricao.participante = Participante.objects.filter(
            utilizador_ptr_id=self.request.user.id).first()
        inscricao.meio_transporte = form_dict['transporte'].cleaned_data['meio']
        if(form_dict['transporte'].cleaned_data['meio'] != 'outro'):
            inscricao.hora_chegada = form_dict['transporte'].cleaned_data['hora_chegada']
            inscricao.local_chegada = form_dict['transporte'].cleaned_data['local_chegada']
        inscricao.entrecampi = form_dict['transporte'].cleaned_data['entrecampi']
        inscricao.save()
        sessoes = form_dict['sessoes'].cleaned_data['sessoes']
        for sessaoid in sessoes:
            if sessoes[sessaoid] > 0:
                inscricao_sessao = Inscricaosessao(sessao=Sessao.objects.get(
                    pk=sessaoid), nparticipantes=sessoes[sessaoid], inscricao=inscricao)
                add_vagas_sessao(sessaoid, -sessoes[sessaoid])
                inscricao_sessao.save()
        responsaveis.inscricao = inscricao
        responsaveis.save()
        if almoco is not None:
            almoco.inscricao = inscricao
            almoco.save()
        enviar_mail_confirmacao_inscricao(self.request, inscricao.pk)
        return render(self.request, 'inscricoes/consultar_inscricao_submissao.html', {
            'inscricao': inscricao,
        })


class ConsultarInscricao(View):
    """ View que gera o formulário com passos para consultar ou alterar uma inscrição """
    template_prefix = 'inscricoes/consultar_inscricao'
    step_names = [
        'responsaveis',
        'escola',
        'transporte',
        'almoco',
        'sessoes',
        'submissao'
    ]

    def get(self, request, pk, step=0, alterar=False):
        inscricao = get_object_or_404(Inscricao, pk=pk)
        erro_permissoes = nao_tem_permissoes(request, inscricao)
        if erro_permissoes:
            return erro_permissoes
        if user_check(request, [Participante])['exists'] and datetime.now(pytz.UTC) > inscricao.diaaberto.datainscricaoatividadesfim:
            m = f"Não pode alterar a inscrição fora do período: {inscricao.diaaberto.datainscricaoatividadesinicio.strftime('%d/%m/%Y')} até {inscricao.diaaberto.datainscricaoatividadesfim.strftime('%d/%m/%Y')}"
            return render(request=request, template_name="mensagem.html", context={'m': m, 'tipo': 'error', 'continuar': 'on'})
        form = init_form(self.step_names[step], inscricao)
        context = {'alterar': alterar,
                   'pk': pk,
                   'step': step,
                   'individual': inscricao.individual,
                   'form': form,
                   }
        update_context(context, self.step_names[step], inscricao=inscricao)
        return render(request, f"{self.template_prefix}_{self.step_names[step]}.html", context)

    def post(self, request, pk, step=0, alterar=False):
        inscricao = get_object_or_404(Inscricao, pk=pk)
        erro_permissoes = nao_tem_permissoes(request, inscricao)
        if erro_permissoes:
            return erro_permissoes
        context = {}
        if alterar:
            if request.user.groups.filter(name="Participante").exists() and datetime.now(pytz.UTC) > inscricao.diaaberto.datainscricaoatividadesfim:
                m = f"Não pode alterar a inscrição fora do período: {inscricao.diaaberto.datainscricaoatividadesinicio.strftime('%d/%m/%Y')} até {inscricao.diaaberto.datainscricaoatividadesfim.strftime('%d/%m/%Y')}"
                return render(request=request, template_name="mensagem.html", context={'m': m, 'tipo': 'error', 'continuar': 'on'})
            update_post(self.step_names[step],
                        request.POST, inscricao=inscricao)
            form = init_form(self.step_names[step], inscricao, request.POST)
            inscricoessessao = inscricao.inscricaosessao_set.all()
            if self.step_names[step] == 'sessoes':
                for inscricao_sessao in inscricoessessao:
                    add_vagas_sessao(inscricao_sessao.sessao.id,
                                     inscricao_sessao.nparticipantes)
            if form.is_valid():
                save_form(request, self.step_names[step], form, inscricao)
                return HttpResponseRedirect(reverse('inscricoes:consultar-inscricao', kwargs={'pk': pk, 'step': step}))
            if self.step_names[step] == 'sessoes':
                for inscricao_sessao in inscricoessessao:
                    add_vagas_sessao(inscricao_sessao.sessao.id,
                                     -inscricao_sessao.nparticipantes)
        context.update({'alterar': alterar,
                        'pk': pk,
                        'step': step,
                        'individual': inscricao.individual,
                        'form': form,
                        })
        update_context(context, self.step_names[step], inscricao=inscricao)
        return render(request, f"{self.template_prefix}_{self.step_names[step]}.html", context)


class ConsultarInscricoes(SingleTableMixin, FilterView):
    """ View base para gerar tabelas com inscrições """
    table_class = InscricoesTable

    filterset_class = InscricaoFilter

    table_pagination = {
        'per_page': 10
    }

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        table = self.get_table(**self.get_table_kwargs())
        table.fixed = True
        context[self.get_context_table_name(table)] = table
        return context

    def get_filterset_kwargs(self, filterset_class):
        kwargs = super(ConsultarInscricoes, self).get_filterset_kwargs(
            filterset_class)
        if kwargs["data"] is None:
            kwargs["data"] = {"diaaberto": Diaaberto.objects.filter(
                ano__lte=datetime.now().year).order_by('-ano').first().id}
        elif "diaaberto" not in kwargs["data"]:
            kwargs["data"] = kwargs["data"].copy()
            kwargs["data"]["diaaberto"] = Diaaberto.objects.filter(
                ano__lte=datetime.now().year).order_by('-ano').first().id
        return kwargs


class MinhasInscricoes(ConsultarInscricoes):
    """ View que gera uma tabela com as inscrições do participante """
    template_name = 'inscricoes/consultar_inscricoes_participante.html'

    def dispatch(self, request, *args, **kwargs):
        user_check_var = user_check(
            request=request, user_profile=[Participante])
        if not user_check_var.get('exists'):
            return user_check_var.get('render')
        return super().dispatch(request, *args, **kwargs)

    def get_queryset(self):
        return Inscricao.objects.filter(participante__user_ptr=self.request.user)


class InscricoesUO(ConsultarInscricoes):
    """ View que gera uma tabela com as inscrições com pelo menos uma sessão do departamento
    do coordenador """
    template_name = 'inscricoes/consultar_inscricoes_coordenador.html'

    def dispatch(self, request, *args, **kwargs):
        user_check_var = user_check(request=request, user_profile=[
            Coordenador])
        if not user_check_var.get('exists'):
            return user_check_var.get('render')
        coordenador = Coordenador.objects.get(user_ptr=request.user)
        self.queryset = Inscricao.objects.filter(
            Exists(Inscricaosessao.objects.filter(
                inscricao=OuterRef('pk'),
                sessao__atividadeid__professoruniversitarioutilizadorid__faculdade=coordenador.faculdade
            ))
        )
        return super().dispatch(request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        coordenador = Coordenador.objects.get(user_ptr=self.request.user)
        context["departamentos"] = list(
            map(lambda x: (x.id, x.nome), Departamento.objects.filter(unidadeorganicaid=coordenador.faculdade)))
        return context


class InscricoesAdmin(ConsultarInscricoes):
    """ View que gera uma tabela com as todas as inscrições """
    template_name = 'inscricoes/consultar_inscricoes_admin.html'

    def dispatch(self, request, *args, **kwargs):
        user_check_var = user_check(request=request, user_profile=[
            Administrador])
        if not user_check_var.get('exists'):
            return user_check_var.get('render')
        return super().dispatch(request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["departamentos"] = list(
            map(lambda x: (x.id, x.nome), Departamento.objects.all()))
        return context


def ApagarInscricao(request, pk):
    """ View que apaga uma inscrição """
    inscricao = get_object_or_404(Inscricao, pk=pk)
    erro_permissoes = nao_tem_permissoes(request, inscricao)
    if erro_permissoes:
        return erro_permissoes
    inscricaosessao_set = inscricao.inscricaosessao_set.all()
    for inscricaosessao in inscricaosessao_set:
        sessaoid = inscricaosessao.sessao.id
        nparticipantes = inscricaosessao.nparticipantes
        add_vagas_sessao(sessaoid, nparticipantes)
    inscricao.delete()
    return HttpResponseRedirect(request.META.get('HTTP_REFERER', '/'))


def estatisticas(request, diaabertoid=None):
    """ View que mostra as estatísticas do Dia Aberto """
    user_check_var = user_check(request=request, user_profile=[Administrador])
    if not user_check_var.get('exists'):
        return user_check_var.get('render')
    if diaabertoid is None:
        try:
            diaabertoid = Diaaberto.objects.filter(
                ano__lte=datetime.now().year).order_by('-ano').first().id
        except:
            return redirect('utilizadores:mensagem', 18)
    diaaberto = get_object_or_404(Diaaberto, id=diaabertoid)
    numdays = int((diaaberto.datadiaabertofim -
                   diaaberto.datadiaabertoinicio).days)+1
    dias = [(diaaberto.datadiaabertoinicio + timedelta(days=x)
             ).strftime("%d/%m/%Y") for x in range(numdays)]
    return render(request, 'inscricoes/estatisticas.html', {
        'diaaberto': diaaberto,
        'diasabertos': Diaaberto.objects.all(),
        'departamentos': Departamento.objects.filter(
            Exists(
                Atividade.objects.filter(
                    professoruniversitarioutilizadorid__departamento__id=OuterRef(
                        'id'),
                    diaabertoid__id=diaabertoid,
                    estado="Aceite",
                )
            )
        ),
        'dias': dias,
        'meios': Inscricao.MEIO_TRANSPORTE_CHOICES,
    })


def tipo_estatistica(request):
    dias_abertos = Diaaberto.objects.order_by('-ano').all()  # Ordenar por ano de forma descendente
    selected_year = dias_abertos[0].id if dias_abertos else None  # Pegar o ID do primeiro objeto, que é o mais recente
    
    return render(request, 'inscricoes/tipo_estatistica.html', {
        'diasabertos': dias_abertos,
        'selected_year': selected_year  # Passar o selected_year para o template
    })



def estatisticaAtividade(request, diaabertoid=None):
    """ View que mostra as estatísticas do Dia Aberto baseadas nas respostas ao questionário """
    user_check_var = user_check(request=request, user_profile=[Administrador])
    if not user_check_var.get('exists'):
        return user_check_var.get('render')
    
    if diaabertoid is None:
        diaaberto = Diaaberto.objects.filter(ano__lte=datetime.now().year).order_by('-ano').first()
        
        if diaaberto is None:
            return render(request, 'mensagem.html', {
                'tipo': 'error',
                'm': 'Nao existe o dia aberto selecionado'
            })
    else:
        try:
            diaaberto = Diaaberto.objects.get(id=diaabertoid)
        except Diaaberto.DoesNotExist:
            return render(request, 'mensagem.html', {
                'tipo': 'error',
                'm': 'Nao existe o dia aberto selecionado'
            })

    if diaaberto.questionario_id is None:
        return render(request, 'mensagem.html', {
            'tipo': 'error',
            'm': 'Nao existe nenhum questionario para esse dia aberto'
        })

    questionario = diaaberto.questionario
   
    
    tema_atividade = TemaQ.objects.filter(tema='Atividade').first()
    
    if tema_atividade is None:
        return render(request, 'mensagem.html', {
            'tipo': 'error',
            'm': 'Nao existe um tema de atividades definido'
        })

    inscricoes = Inscricao.objects.filter(diaaberto=diaaberto)
    
    
    if not inscricoes.exists():
        return render(request, 'mensagem.html', {
            'tipo': 'error',
            'm': 'Nao existem inscrições para este dia aberto'
        })
    
    codigos = inscricoes.values_list('codigo', flat=True)
    print("codigos", codigos)
   
    
    respostas = Resposta.objects.filter(codigo__in=codigos)
    
    
    inscricoes_sessao = Inscricaosessao.objects.filter(inscricao__in=inscricoes).select_related('sessao__atividadeid', 'sessao__roteiroid')

    atividades = list(set(inscricao_sessao.sessao.atividadeid for inscricao_sessao in inscricoes_sessao if inscricao_sessao.sessao.atividadeid))
    print("Atividades", atividades)
    roteiros = list(set(inscricao_sessao.sessao.roteiroid for inscricao_sessao in inscricoes_sessao if inscricao_sessao.sessao.roteiroid))

    perguntas = Pergunta.objects.filter(questionario_id=questionario.id, tema=tema_atividade.id, tipo_resposta='multipla_escolha')

    respostas_individuais = Resposta_Individual.objects.filter(resposta__in=respostas)
    print("respostasInd", respostas_individuais)

    if not atividades and not roteiros:
        return render(request, 'mensagem.html', {
            'tipo': 'error',
            'mensagem': 'Não existem atividades ou roteiros com questionários para este Dia Aberto.'
        })
    
    resultados = []
    for pergunta in perguntas:
        # Filtrar respostas individuais e opções relacionadas à pergunta
        respostas_individuais = Resposta_Individual.objects.filter(pergunta=pergunta)
        opcoes = OpcaoP.objects.filter(pergunta=pergunta).in_bulk(field_name='id')

        # Preparar dicionário para contar as respostas
        contador_respostas = defaultdict(int)

        # Contar respostas recebidas, mapeando o id da opção para seu texto_opcao
        for resposta in respostas_individuais:
            id_opcao = resposta.resposta_texto  # Aqui, assumimos que resposta_texto armazena o id da opção
            texto_opcao = opcoes[int(id_opcao)].texto_opcao if int(id_opcao) in opcoes else 'Opção não encontrada'
            contador_respostas[texto_opcao] += 1

        # Agora, preparar a lista de respostas agrupadas para inclusão nos resultados
        respostas_agrupadas = [{'texto_opcao': texto_opcao, 'total': total} for texto_opcao, total in contador_respostas.items()]

        resultados.append({
            'pergunta': pergunta.texto,
            'respostas': respostas_agrupadas,
        })
    
    numdays = (diaaberto.datadiaabertofim - diaaberto.datadiaabertoinicio).days + 1
    dias = [(diaaberto.datadiaabertoinicio + timedelta(days=x)).strftime("%d/%m/%Y") for x in range(numdays)]

    return render(request, 'inscricoes/EstatisticaAtividade.html', {
        'diaaberto': diaaberto,
        'diasabertos': Diaaberto.objects.all(),
        'departamentos': Departamento.objects.filter(
            Exists(
                Atividade.objects.filter(
                    professoruniversitarioutilizadorid__departamento__id=OuterRef('id'),
                    diaabertoid=diaaberto,
                    estado="Aceite",
                )
            )
        ),
        'dias': dias,
        'questionario': questionario,
        'resultados': resultados,
        'atividades': atividades,
        'roteiros': roteiros
    })


def estatisticaporAtividade(request, atividadeid):
    """ View que mostra as estatísticas de uma atividade específica baseadas nas respostas ao questionário """
    user_check_var = user_check(request=request, user_profile=[Administrador])
    if not user_check_var.get('exists'):
        return user_check_var.get('render')
    
    # Obter a atividade ou redirecionar se não existir
    atividade = get_object_or_404(Atividade, id=atividadeid)
    print("atividade",atividade)
    
    # Obter o Dia Aberto relacionado à atividade
    diaaberto = Diaaberto.objects.filter(
        ano__lte=datetime.now().year).order_by('-ano').first()
    print("diaaberto", diaaberto)
    if not diaaberto:
       return render(request, 'mensagem.html', {
            'tipo': 'error',
            'm': 'Nao existe esse dia aberto'
        })
    
 
    questionario = diaaberto.questionario
    print("questionarios", questionario)
    
    tema_atividade = TemaQ.objects.filter(tema='Atividade').first()
    
    if tema_atividade is None:
        return render(request, 'mensagem.html', {
            'tipo': 'error',
            'm': 'Nao existe um tema de atividades definido'
        })

    # Filtrar inscrições e respostas relacionadas à atividade específica
    inscricoes_sessao = Inscricaosessao.objects.filter(sessao__atividadeid=atividade)
    inscricoes = Inscricao.objects.filter(id__in=inscricoes_sessao.values_list('inscricao_id', flat=True))
    
    if not inscricoes.exists():
        return render(request, 'mensagem.html', {
            'tipo': 'error',
            'm': 'Nao existem inscrições para esta atividade'
        })
    
    codigos = inscricoes.values_list('codigo', flat=True)
    print("codigos", codigos)
    
    respostas = Resposta.objects.filter(codigo__in=codigos)
    print("respostas", respostas)
    
    perguntas = Pergunta.objects.filter(questionario_id=questionario, tema=tema_atividade, tipo_resposta='multipla_escolha')

    #respostas_individuais = Resposta_Individual.objects.filter(resposta__in=respostas)


    resultados = []
    for pergunta in perguntas:
        # Filtrar respostas individuais e opções relacionadas à pergunta
        respostas_individuais = Resposta_Individual.objects.filter(resposta__in=respostas).filter(pergunta=pergunta)
        opcoes = OpcaoP.objects.filter(pergunta=pergunta).in_bulk(field_name='id')

        # Preparar dicionário para contar as respostas
        contador_respostas = defaultdict(int)

        # Contar respostas recebidas, mapeando o id da opção para seu texto_opcao
        for resposta in respostas_individuais:
            id_opcao = resposta.resposta_texto  # Aqui, assumimos que resposta_texto armazena o id da opção
            texto_opcao = opcoes[int(id_opcao)].texto_opcao if int(id_opcao) in opcoes else 'Opção não encontrada'
            contador_respostas[texto_opcao] += 1

        # Agora, preparar a lista de respostas agrupadas para inclusão nos resultados
        respostas_agrupadas = [{'texto_opcao': texto_opcao, 'total': total} for texto_opcao, total in contador_respostas.items()]

        resultados.append({
            'pergunta': pergunta.texto,
            'respostas': respostas_agrupadas,
        })
    
    
    return render(request, 'inscricoes/EstatisticaporAtividade.html', {
        'diaabertoid': diaaberto.id,
        'questionario': questionario,
        'resultados': resultados,
        'atividade': atividade
    })





def estatisticaporRoteiro(request, roteiroid=None):
    """ View que mostra as estatísticas de um roteiro específico baseadas nas respostas ao questionário """
    user_check_var = user_check(request=request, user_profile=[Administrador])
    if not user_check_var.get('exists'):
        return user_check_var.get('render')
    
    # Obter o roteiro ou redirecionar se não existir
    roteiro = get_object_or_404(Roteiro, id=roteiroid)
    print("roteiro", roteiro)
    
    # Obter o Dia Aberto relacionado ao roteiro
    diaaberto = Diaaberto.objects.filter(ano__lte=datetime.now().year).order_by('-ano').first()
    print("diaaberto", diaaberto)
    if not diaaberto:
        return render(request, 'mensagem.html', {
            'tipo': 'error',
            'm': 'Nao existe esse dia aberto'
        })
    
    questionario = diaaberto.questionario
    print("questionarios", questionario)
    
    tema_atividade = TemaQ.objects.filter(tema='Atividade').first()
    
    if tema_atividade is None:
        return render(request, 'mensagem.html', {
            'tipo': 'error',
            'm': 'Nao existe um tema de atividades definido'
        })

    # Filtrar inscrições e respostas relacionadas ao roteiro específico
    inscricoes_sessao = Inscricaosessao.objects.filter(sessao__roteiroid=roteiro)
    inscricoes = Inscricao.objects.filter(id__in=inscricoes_sessao.values_list('inscricao_id', flat=True))
    
    if not inscricoes.exists():
        return render(request, 'mensagem.html', {
            'tipo': 'error',
            'm': 'Nao existem inscrições para este roteiro'
        })
    
    codigos = inscricoes.values_list('codigo', flat=True)
    print("codigos", codigos)
    
    respostas = Resposta.objects.filter(codigo__in=codigos)
    print("respostas", respostas)
    
    perguntas = Pergunta.objects.filter(questionario_id=questionario, tema=tema_atividade, tipo_resposta='multipla_escolha')

    #respostas_individuais = Resposta_Individual.objects.filter(resposta__in=respostas)
    #print("respostas_individuais", respostas_individuais)

    resultados = []
    for pergunta in perguntas:
        # Filtrar respostas individuais e opções relacionadas à pergunta
        respostas_individuais = Resposta_Individual.objects.filter(resposta__in=respostas).filter(pergunta=pergunta)
        opcoes = OpcaoP.objects.filter(pergunta=pergunta).in_bulk(field_name='id')

        # Preparar dicionário para contar as respostas
        contador_respostas = defaultdict(int)

        # Contar respostas recebidas, mapeando o id da opção para seu texto_opcaos
        for resposta in respostas_individuais:
            id_opcao = resposta.resposta_texto  # Aqui, assumimos que resposta_texto armazena o id da opção
            texto_opcao = opcoes[int(id_opcao)].texto_opcao if int(id_opcao) in opcoes else 'Opção não encontrada'
            contador_respostas[texto_opcao] += 1

        # Agora, preparar a lista de respostas agrupadas para inclusão nos resultados
        respostas_agrupadas = [{'texto_opcao': texto_opcao, 'total': total} for texto_opcao, total in contador_respostas.items()]

        resultados.append({
            'pergunta': pergunta.texto,
            'respostas': respostas_agrupadas,
        })
    
    
    return render(request, 'inscricoes/EstatisticaporRoteiro.html', {
        'diaabertoid': diaaberto.id,
        'questionario': questionario,
        'resultados': resultados,
        'roteiros': roteiro
    })






def estatistica_transporte(request, diaabertoid=None):
    """ View que mostra as estatísticas do Dia Aberto baseadas nas respostas ao questionário """
    user_check_var = user_check(request=request, user_profile=[Administrador])
    if not user_check_var.get('exists'):
        return user_check_var.get('render')
    
    if diaabertoid is None:
        diaabertoid = Diaaberto.objects.filter(
            ano__lte=datetime.now().year).order_by('-ano').first()
        if not diaabertoid:
            return redirect('utilizadores:mensagem', 18)
    
    diaaberto = get_object_or_404(Diaaberto, id=diaabertoid)
    if not diaaberto.questionario_id:
        return redirect('utilizadores:mensagem1', 19)

    questionario = get_object_or_404(Questionario, id=diaaberto.questionario_id)
    tema_transporte = get_object_or_404(TemaQ, tema='Transporte')

    perguntas = Pergunta.objects.filter(questionario_id=questionario.id, tema=tema_transporte.id, tipo_resposta='multipla_escolha')
    if not perguntas.exists():
        return redirect('utilizadores:mensagem1', 19)

    resultados = []
    for pergunta in perguntas:
        # Filtrar respostas individuais e opções relacionadas à pergunta
        respostas_individuais = Resposta_Individual.objects.filter(pergunta=pergunta)
        opcoes = OpcaoP.objects.filter(pergunta=pergunta).in_bulk(field_name='id')

        # Preparar dicionário para contar as respostas
        contador_respostas = defaultdict(int)

        # Contar respostas recebidas, mapeando o id da opção para seu texto_opcao
        for resposta in respostas_individuais:
            id_opcao = resposta.resposta_texto  # Aqui, assumimos que resposta_texto armazena o id da opção
            texto_opcao = opcoes[int(id_opcao)].texto_opcao if int(id_opcao) in opcoes else 'Opção não encontrada'
            contador_respostas[texto_opcao] += 1

        # Agora, preparar a lista de respostas agrupadas para inclusão nos resultados
        respostas_agrupadas = [{'texto_opcao': texto_opcao, 'total': total} for texto_opcao, total in contador_respostas.items()]

        resultados.append({
            'pergunta': pergunta.texto,
            'respostas': respostas_agrupadas,
        })

       

    numdays = (diaaberto.datadiaabertofim - diaaberto.datadiaabertoinicio).days + 1
    dias = [(diaaberto.datadiaabertoinicio + timedelta(days=x)).strftime("%d/%m/%Y") for x in range(numdays)]

    return render(request, 'inscricoes/estatistica_transporte.html', {
        'diaaberto': diaaberto,
        'diasabertos': Diaaberto.objects.all(),
        'departamentos': Departamento.objects.filter(
            Exists(
                Atividade.objects.filter(
                    professoruniversitarioutilizadorid__departamento__id=OuterRef('id'),
                    diaabertoid=diaaberto,
                    estado="Aceite",
                )
            )
        ),
        'dias': dias,
        'meios': Inscricao.MEIO_TRANSPORTE_CHOICES,
        'questionario': questionario,
        'resultados': resultados
    })

def exportar_estatisticas_csv(request, diaabertoid=None):

    # Checar se o usuário é um administrador
    user_check_var = user_check(request=request, user_profile=[Administrador])
    if not user_check_var.get('exists'):
        return user_check_var.get('render')

    if diaabertoid is None:
        diaabertoid = Diaaberto.objects.filter(
            ano__lte=datetime.now().year).order_by('-ano').first()
        if not diaabertoid:
            return redirect('utilizadores:mensagem', 18)

    diaaberto = get_object_or_404(Diaaberto, id=diaabertoid)
    if not diaaberto.questionario_id:
        return redirect('utilizadores:mensagem1', 19)

    questionario = get_object_or_404(Questionario, id=diaaberto.questionario_id)
    tema_transporte = get_object_or_404(TemaQ, tema='Transporte')
    perguntas = Pergunta.objects.filter(questionario_id=questionario.id, tema=tema_transporte.id, tipo_resposta='multipla_escolha')

    # Preparar o CSV
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachment; filename="estatisticas_transporte.csv"'
    response.write(u'\ufeff'.encode('utf8'))  # Adiciona o BOM para UTF-8
    writer = csv.writer(response, delimiter=';', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    writer.writerow(['Pergunta', 'Opção de Resposta', 'Total', 'Percentagem'])

    for pergunta in perguntas:
        respostas_individuais = Resposta_Individual.objects.filter(pergunta=pergunta).values('resposta_texto').annotate(total=Count('resposta_texto')).order_by('-total')
        total_respostas = sum(resposta['total'] for resposta in respostas_individuais)  # Soma total
        opcoes = OpcaoP.objects.filter(id__in=[int(r['resposta_texto']) for r in respostas_individuais if r['resposta_texto'].isdigit()]).in_bulk()

        first = True
        for resposta in respostas_individuais:
            id_opcao = int(resposta['resposta_texto'])
            texto_opcao = opcoes[id_opcao].texto_opcao if id_opcao in opcoes else 'Opção não encontrada'
            # Prevenir formatação automática de datas
            texto_opcao = f"'{texto_opcao}"
            percentagem = (resposta['total'] / total_respostas) * 100 if total_respostas > 0 else 0
            if first:
                writer.writerow([pergunta.texto, texto_opcao, resposta['total'], f"{percentagem:.2f}%"])
                first = False
            else:
                writer.writerow(['', texto_opcao, resposta['total'], f"{percentagem:.2f}%"])
        writer.writerow([])

    return response

from django.shortcuts import render
from configuracao.models import Diaaberto,Menu, Prato
from questionariosPublicados.models import *
# Create your views here.
import json

def estatisticas_almocos(request, diaabertoid=None):
    dias_abertos = Diaaberto.objects.all()
    nome_questionario = None
    data_publicacao = None
    respostas_json_escolhas = []
    respostas_almocos_escolhas_multiplas = []
    respostas_json = []
    perguntas_almocos = []
    respostas= ""
    participantes= 0
    ano_diaaberto = None

    user_check_var = user_check(request=request, user_profile=[Administrador])
    if not user_check_var.get('exists'):
        return user_check_var.get('render')
    
    if diaabertoid is None:
        diaabertoid = Diaaberto.objects.filter(
            ano__lte=datetime.now().year).order_by('-ano').first()
        if not diaabertoid:
            return redirect('utilizadores:mensagem', 18)
    
    diaaberto = get_object_or_404(Diaaberto, id=diaabertoid)
    if not diaaberto.questionario_id:
        return redirect('utilizadores:mensagem1', 19)
    
    print("diaaberto: ", diaaberto)
    print("diaabertoID: ", diaabertoid)
    if diaabertoid != "":
        diaaberto = Diaaberto.objects.get(id=diaabertoid)
        print("Gustavo",diaaberto)
        ano_diaaberto = diaaberto.ano #ano do dia aberto
        if diaaberto.questionario == None: #n tÊm questionarios associados
            respostas= "No"
            print(respostas)
        else:
            nome_questionario = diaaberto.questionario.nome
            questionarioId = diaaberto.questionario.id
            data_publicacao = diaaberto.questionario.data_publicada
            data_expiracao = diaaberto.questionario.data_fim_publicacao
            perguntasquestionario = Pergunta.objects.filter(questionario=questionarioId).all()
            
            temaAlmoco = False
            for perg in perguntasquestionario:
                if perg.tema.tema == "Almoço":
                    perguntas_almocos.append(perg)
                    temaAlmoco = True
                    
            if temaAlmoco == True:
                get_respostas = Resposta.objects.filter(questionario=questionarioId).all()
                if get_respostas.count() == 0: # n há respostas
                    respostas= "False"
                else: #Calcular o numero de respostas
                    respostas= "True"
                    participantes = get_respostas.count()                
                    respostas_almocos = []
                    respostas_almocos_escolhas_multiplas = []
                    id = 0
                    for pergunta in perguntas_almocos:
                        resposta_alm = {}
                        resposta_alm['id']  = id
                        resposta_alm['pergunta'] = pergunta.texto
                        resposta_alm['tipo_pergunta'] = pergunta.tipo_resposta
                        resposta_alm['respostas'] = []
                        if pergunta.tipo_resposta == 'multipla_escolha':
                            opcoes = pergunta.opcoes.all()
                            
                            for opcao in opcoes:
                                # Contar quantas vezes esta opção foi selecionada
                                count_opcao = Resposta_Individual.objects.filter(
                                    resposta__in=get_respostas,
                                    pergunta=pergunta,
                                    resposta_texto=str(opcao.id)  
                                ).count()

                                percentagem_opcao = (count_opcao / participantes) * 100
                                

                                resposta_alm['respostas'].append({
                                    'opcao': opcao.texto_opcao,
                                    'count': percentagem_opcao
                                })
                            respostas_almocos_escolhas_multiplas.append(resposta_alm)
                            
                            id = id + 1
                
                        respostas_almocos.append(resposta_alm)

                        

                    respostas_json = json.dumps(respostas_almocos) 
                    respostas_json_escolhas = json.dumps(respostas_almocos_escolhas_multiplas) 
                            
                        
       
        return render(request, 'inscricoes/estatisticas_almocos.html',
                  context={'diasAbertos':dias_abertos,
                           'participantes':participantes,'respostas':respostas,
                           'respostas_almocos':respostas_json,
                           'respostas_almocos_escolhas_multiplas': respostas_almocos_escolhas_multiplas
                           ,'respostas_escolhas_multiplas_json':respostas_json_escolhas
                           ,'data_publicacao':data_publicacao
                           ,'data_expiracao':data_expiracao
                           ,'ano_diaaberto':ano_diaaberto
                           ,'diaabertoID':diaabertoid
                        ,'nome_questionario': nome_questionario});


def exportar_para_csv(request):
    diaabertoID = request.GET.get('diaaberto')  # Pegue o ID do Dia Aberto do parâmetro da URL
    
    # Criar a resposta HTTP com tipo de conteúdo CSV
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = f'attachment; filename="estatisticas_almocos_{diaabertoID}.csv"'
    
    writer = csv.writer(response)
    writer.writerow(['Pergunta', 'Opções', 'Total', 'Porcentagem'])  # Cabeçalhos das colunas
    
    if diaabertoID:
        try:
            diaaberto = Diaaberto.objects.get(id=diaabertoID)
        except Diaaberto.DoesNotExist:
            return HttpResponse("Dia Aberto não encontrado.", content_type="text/plain")
        
        if diaaberto.questionario:
            questionarioId = diaaberto.questionario.id
            perguntas = Pergunta.objects.filter(questionario=questionarioId, tema__id=1, tipo_resposta='multipla_escolha').all()
            
            if perguntas:
                for pergunta in perguntas:
                    opcoes = pergunta.opcoes.all()
                    total_respostas = Resposta_Individual.objects.filter(pergunta=pergunta).count()
                    
                    for opcao in opcoes:
                        count_respostas_opcao = Resposta_Individual.objects.filter(pergunta=pergunta, resposta_texto=str(opcao.id)).count()
                        porcentagem = (count_respostas_opcao / total_respostas * 100) if total_respostas > 0 else 0
                        writer.writerow([
                            pergunta.texto if opcao == opcoes.first() else '',  # Mostra o texto da pergunta apenas na primeira opção
                            opcao.texto_opcao,
                            count_respostas_opcao,
                            f"{porcentagem:.2f}%"
                        ])
                    writer.writerow([])  # Linha vazia após as opções de cada pergunta
            else:
                writer.writerow(['Não há perguntas de múltipla escolha associadas a este questionário.'])
        else:
            return HttpResponse("Não há questionário associado ao Dia Aberto selecionado.", content_type="text/plain")
    else:
        return HttpResponse("ID do Dia Aberto não fornecido ou inválido.", content_type="text/plain")
    
    return response



def presençaInscricao(request,inscricao_id):
    user_check_var = user_check(request=request, user_profile=[Administrador])
    if user_check_var.get('exists') == False:
        return user_check_var.get('render')
    if inscricao_id is not None:
        inscricao = Inscricao.objects.get(id=inscricao_id)
        allowMore, allowDelete = False, False

    return render(request=request,
                  template_name='inscricoes/consultarPresença.html',context={
                    'inscricao2': Inscricao.objects.get(id=inscricao_id),
                    'inscricaosessoes': Inscricaosessao.objects.all().filter(inscricao=inscricao_id),
                  })