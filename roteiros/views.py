from django.db import OperationalError
from django.forms import ValidationError
from django.http import HttpResponse
from django.shortcuts import get_object_or_404, redirect, render
from django_tables2 import SingleTableMixin
from django.db.models import Sum, Max

from atividades.forms import AtividadeForm
from atividades.views import Chorarios, TimeC, conflict_array, horariofim


from django.shortcuts import render
from inscricoes.utils import render_pdf


from notificacoes import views
from relatorios.views import create_report
from roteiros.forms import  RoteiroForm
from roteiros.models import Roteiro
from utilizadores.models import  Coordenador
from configuracao.models import Campus, Departamento, Diaaberto, Horario
from datetime import datetime,timezone
from datetime import timedelta

from utilizadores.views import user_check

from atividades.tables import *
from atividades.filters import *
from django_filters.views import FilterView
from roteiros.tablesRoteiro import *
from roteiros.filters import *
from django.utils.timezone import now


def handle_db_errors(view_func):
    def wrapper(request, *args, **kwargs):
        try:
            response = view_func(request, *args, **kwargs)
            return response
        except OperationalError as e:
            print(f"Database error encountered: {e}")
            return render(request, "db_error.html", status=503)
    return wrapper

class RoteiroCoordenador(SingleTableMixin, FilterView):
    
    table_class = CoordRoteiroTable
    template_name = 'roteiros/meusRoteiros.html'
    filterset_class = CoordRoteiroFilter
    table_pagination = {
		'per_page': 10
	}
    
    @handle_db_errors
    def dispatch(self, request, *args, **kwargs):
        user_check_var = user_check(request=request, user_profile=[Coordenador])
        if not user_check_var.get('exists'): return user_check_var.get('render')
        self.user_check_var = user_check_var
        return super().dispatch(request, *args, **kwargs)

    def get_queryset(self):
        return Roteiro.objects.filter(coordenadorID=self.user_check_var.get('firstProfile')).order_by('-id')
    

@handle_db_errors
def roteiros(request):
    roteiros = Roteiro.objects.all()
    return render(request, 'roteiros/meusRoteiros.html',{'roteiro': roteiros})

# selecionar atividades por unidade organica
@handle_db_errors
def proporRoteiro(request):
    user_check_var = user_check(request=request, user_profile=[Coordenador])
    if user_check_var.get('exists') == False:
        return user_check_var.get('render')
    today= datetime.now(timezone.utc) 
    try:
       diaabertopropostas=Diaaberto.objects.get(datapropostasatividadesincio__lte=today,dataporpostaatividadesfim__gte=today)
    except Diaaberto.DoesNotExist:
         return render(request=request,
                          template_name='mensagem.html',
                          context={'tipo': 'error', 'm': 'A data para propor Roteiros ja terminou'})

    coordenador = Coordenador.objects.get(utilizador_ptr_id=request.user.id)
    unidade_organica = coordenador.faculdade
    atividades = Atividade.objects.filter(professoruniversitarioutilizadorid__faculdade=unidade_organica, estado='Aceite')

    if not atividades.exists():
        return render(request=request,
                          template_name='mensagem.html',
                          context={'tipo': 'error', 'm': 'Não existem atividades para este dia aberto'})
 
    
    diainicio= diaabertopropostas.datadiaabertoinicio.date()
    diafim= diaabertopropostas.datadiaabertofim.date()
    totaldias= diafim-diainicio+timedelta(days=1)
    dias_diaaberto= []
    for d in range(totaldias.days):
        dias_diaaberto.append(diainicio+timedelta(days=d))
   
    if request.method == "POST":
        roteiro_form = RoteiroForm(request.POST)
        new_form = Roteiro(coordenadorID = Coordenador.objects.get(utilizador_ptr_id = request.user.id), diaabertoid = diaabertopropostas)
        roteiro_object_form = RoteiroForm(request.POST, instance=new_form)
        if roteiro_object_form.is_valid():
            atividades_ids = request.POST.getlist('atividades_ids')
            print("Atividades_ids", atividades_ids)
            if len(atividades_ids) < 2:
                return render(request, 'mensagemRoteiro.html', {
                    'tipo': 'error',
                    'm': 'Tem de Selecionar pelo menos duas atividades.',
                    'continuar': True,  # Adicione esta linha para mostrar o botão Continuar
                    'url': reverse('roteiros:proporRoteiro')  # Ajuste 'home' para a URL de redirecionamento desejada
                })
            else:
                print("aaaaaaaaaaaaaaaaaaaaaaa")
                atividades_selecionadas = Atividade.objects.filter(id__in=atividades_ids)
                maior_duracao = atividades_selecionadas.aggregate(maior_duracao=Max('duracaoesperada'))['maior_duracao']
                countAtividades = atividades_selecionadas.count()
                new_form.duracaoesperada = maior_duracao * countAtividades
                roteiro_object_formed = roteiro_object_form.save()
                Atividade.objects.filter(id__in=atividades_ids).update(roteiro=roteiro_object_formed)
                
                return redirect('roteiros:sessaoRoteiro', roteiro_object_formed.id)  # Ajuste o redirecionamento conforme necessário
    else:
        roteiro_form = RoteiroForm()
        atividades = Atividade.objects.filter(professoruniversitarioutilizadorid__faculdade=unidade_organica)

    return render(request, 'roteiros/proporRoteiro.html', {'form': roteiro_form, 'atividades': atividades})



@handle_db_errors
def inserirsessaoRoteiro(request, id):

    user_check_var = user_check(request=request, user_profile=[Coordenador])
    if user_check_var.get('exists') == False: return user_check_var.get('render')

    userId = user_check_var.get('firstProfile').utilizador_ptr_id
    roteiro = Roteiro.objects.filter(id=id, coordenadorID=userId)

    roteirocheck = roteiro.first()
    sessoes = Sessao.objects.filter(roteiroid=roteirocheck)
    diaaberto = roteirocheck.diaabertoid

    if roteiro.exists():
        today = datetime.now(timezone.utc)
        #diaaberto = Diaaberto.objects.get(datapropostasatividadesincio__lte=today,
         #                                 dataporpostaatividadesfim__gte=today)
        

 
        diainicio = diaaberto.datadiaabertoinicio.date()
        diafim = diaaberto.datadiaabertofim.date()
        totaldias = diafim - diainicio + timedelta(days=1)
        dias_diaaberto = []
        for d in range(totaldias.days):
            dias_diaaberto.append(diainicio + timedelta(days=d))

        horariosindisponiveis = []
        disp = []
        roteiroid = Roteiro.objects.get(id=id)
        
        sessoes = Sessao.objects.all().filter(roteiroid=id)
 
        check = len(sessoes)
    
        if request.method == "POST":
            if 'new' in request.POST:
                diasessao = request.POST["diasessao"]
                #print(diasessao)
                inicio = request.POST['horarioid']
                splitinicio = inicio.split(":")
                #print(splitinicio)
                duracaoesperada = roteiroid.duracaoesperada
                hfim = horariofim(splitinicio, duracaoesperada)
                horario = Horario.objects.filter(inicio=request.POST['horarioid'], fim=hfim).first()

                if horario is None:
                    new_Horario = Horario(inicio=inicio, fim=hfim)
                    new_Horario.save()
                else:
                    new_Horario = horario
                
                sessao_existente = Sessao.objects.filter(horarioid=new_Horario.id, dia=diasessao, roteiroid=roteiroid).first()
                if sessao_existente:
                  return render(request, 'mensagemRoteiro.html', {
                    'tipo': 'error',
                    'm': 'Já existe uma sessão com esse horário.',
                    'continuar': True,  # Adicione esta linha para mostrar o botão Continuar
                    'url': reverse('roteiros:sessaoRoteiro', args=[id])  # Ajuste 'home' para a URL de redirecionamento desejada
                })
                
                
                new_Sessao = Sessao(vagas=Roteiro.objects.get(id=id).participantesmaximo,
                                            ninscritos=0,
                                            horarioid=Horario.objects.get(id=new_Horario.id),
                                            roteiroid=Roteiro.objects.get(id=id),
                                            dia=diasessao)
                roteiroid.save()
                new_Sessao.save()
                roteiro = Roteiro.objects.get(id=id)
        return render(request=request,
                    template_name='roteiros/sessaoRoteiro.html',
                    context={'horarios': "" , 
                            'sessions_activity': Sessao.objects.all().filter(roteiroid= id), 
                            'roteiros': roteiro,
                            'dias': dias_diaaberto,
                            'check': check, "id":id})
    
    
            
           
@handle_db_errors
def verresumo(request,id):

    user_check_var = user_check(request=request, user_profile=[Coordenador])
    if user_check_var.get('exists') == False: return user_check_var.get('render')

    userId = user_check_var.get('firstProfile').utilizador_ptr_id
    roteiro = Roteiro.objects.filter(id=id,coordenadorID=userId)

    roteirocheck= roteiro.first()
    sessoes= Sessao.objects.filter(roteiroid=roteirocheck)
    for sessao in sessoes:
        if sessao.vagas != roteirocheck.participantesmaximo:
            return    render(request=request,
                            template_name='mensagem.html',
                            context={
                                'tipo':'error',
                                'm':'Não tem permissões para esta ação!'
                            })

    if roteiro.exists():  
        roteiro= Roteiro.objects.get(id=id)
        if request.method == "POST":
            if 'anterior' in request.POST:
                return redirect('roteiros:sessaoRoteiro', id)
        sessions_activity= Sessao.objects.filter(roteiroid=roteiro)
        atividades = Atividade.objects.filter(roteiro = roteiro).select_related('espacoid', 'espacoid__edificio')
        return render(request=request, 
                    template_name="roteiros/verResumo.html",  context={"roteiro": roteiro, "sessions_activity": sessions_activity, "atividades": atividades} )
    else:
        return    render(request=request,
                            template_name='mensagem.html',
                            context={
                                'tipo':'error',
                                'm':'Não tem permissões para esta ação!'
                            })
    
@handle_db_errors    
def confirmarResumo(request,id):
    user_check_var = user_check(request=request, user_profile=[Coordenador])
    if user_check_var.get('exists') == False: return user_check_var.get('render')

    userId = user_check_var.get('firstProfile').utilizador_ptr_id
    roteiro = Roteiro.objects.filter(id=id,coordenadorID=userId)

    roteirocheck= roteiro.first()
    sessoes= Sessao.objects.filter(roteiroid=roteirocheck)
    for sessao in sessoes:
        if sessao.vagas != roteirocheck.participantesmaximo:
            return    render(request=request,
                            template_name='mensagem.html',
                            context={
                                'tipo':'error',
                                'm':'Não tem permissões para esta ação!'
                            })

    if roteiro.exists():  
        roteiro = Roteiro.objects.get(id=id)
        #views.enviar_notificacao_automatica(request,"roteiroCriado",roteiro.id)
        Atividade.objects.filter(roteiro=roteiro).update(estado='Aceite')
        return redirect("roteiros:criarRoteiro")
    else:
        return    render(request=request,
                            template_name='mensagem.html',
                            context={
                                'tipo':'error',
                                'm':'Não tem permissões para esta ação!'
                            })   
   

def horariofimRoteiro(inicio,duracao):
    calculo= int(inicio[0])*60+ int(inicio[1])+duracao
    hora=int(calculo/60)
    minutos= int(calculo%60)
    fim= str(hora)+":"+str(minutos)
    return fim   


@handle_db_errors
def eliminarSessaoRoteiro(request,id):
    user_check_var = user_check(request=request, user_profile=[Coordenador])
    if user_check_var.get('exists') == False: return user_check_var.get('render')
    userId = user_check_var.get('firstProfile').utilizador_ptr_id
    sessoes = Sessao.objects.filter(id=id,roteiroid__coordenadorID=userId)

        

    if sessoes.exists():
        sessaor=sessoes.first()
        if sessaor.vagas != sessaor.roteiroid.participantesmaximo:
            return    render(request=request,
                            template_name='mensagem.html',
                            context={
                                'tipo':'error',
                                'm':'Não tem permissões para esta ação!'
                            })
        roteiro= sessaor.roteiroid.id
        sessaor.delete()
        return redirect('roteiros:sessaoRoteiro',roteiro)
    else:
        return    render(request=request,
                            template_name='mensagem.html',
                            context={
                                'tipo':'error',
                                'm':'Não tem permissões para esta ação!'
                            })
    

@handle_db_errors
def eliminarRoteiro(request,id):
    user_check_var = user_check(request=request, user_profile=[Coordenador])
    if user_check_var.get('exists') == False: return user_check_var.get('render')
    roteiro = Roteiro.objects.filter(id=id)
    roteirocheck= roteiro.first()
    sessoes = Sessao.objects.filter(roteiroid=roteirocheck)
    for sessao in sessoes:
        if sessao.vagas != roteirocheck.participantesmaximo:
            return    render(request=request,
                            template_name='mensagem.html',
                            context={
                                'tipo':'error',
                                'm':'Não tem permissões para esta ação!'
                            })

    if roteiro.exists():
        #views.enviar_notificacao_automatica(request,"roteiroEliminado",id) #Enviar Notificacao Automatica !!!!!!
        roteiro.delete()
        return redirect('roteiros:criarRoteiro')
    else:
        return    render(request=request,
                            template_name='mensagem.html',
                            context={
                                'tipo':'error',
                                'm':'Não tem permissões para esta ação!'
                            })
    
@handle_db_errors
def escolherDiaAberto2(request, id):
    roteiro_original = Roteiro.objects.filter(id=id).first()
 
    if not roteiro_original:
        return render(request, 'mensagem.html', {
            'tipo': 'error',
            'm': 'Selecione um roteiro valido'
        })

    dias_abertos = Diaaberto.objects.all()  

    return render(request, 'roteiros/duplicarRoteiro.html', {'dias_abertos': dias_abertos, 'roteiro_id': id})
    
@handle_db_errors
def escolherDiaAberto(request, id):
    atividade = Atividade.objects.filter(id=id).first()
    roteiro_original = atividade.roteiro
    
    if not roteiro_original:
        return render(request, 'mensagem.html', {
            'tipo': 'error',
            'm': 'Não pode duplicar o roteiro que nao tem atividades selecionadas'
        })
     # Determina o dia aberto atual comparando as datas com a data e hora atuais
    hoje = datetime.now()
    dia_aberto_atual = Diaaberto.objects.filter(datadiaabertoinicio__lte=hoje, datadiaabertofim__gte=hoje).first()

    # Verifica se o dia aberto atual do roteiro é o mesmo que o dia ativo.
    if roteiro_original.diaabertoid == dia_aberto_atual:
        return render(request, 'mensagem.html', {
            'tipo': 'error',
            'm': 'Não pode duplicar o roteiro no Dia Aberto atual que está decorrendo.'
        })

    dias_abertos = Diaaberto.objects.all()  

    return render(request, 'roteiros/duplicarRoteiro.html', {'dias_abertos': dias_abertos, 'roteiro_id': roteiro_original.id})
    
@handle_db_errors
def duplicarRoteiro(request, id, novo_diaaberto_id):
    
    roteiro_original = Roteiro.objects.filter(id=id).first()
    novo_diaaberto = Diaaberto.objects.filter(id=novo_diaaberto_id).first() 
   

    existing_roteiro = Roteiro.objects.filter(
        nome=f"{roteiro_original.nome} (Cópia {novo_diaaberto.ano})", 
        diaabertoid=novo_diaaberto
    ).exists()

    if existing_roteiro:
        # If a duplicate Roteiro exists, inform the user and redirect or render a response
       return render(request, 'mensagem.html', {
            'tipo': 'error',
            'm': 'Este roteiro ja existe neste dia aberto'
        })


    if roteiro_original and novo_diaaberto:
        # Cria uma nova instância do roteiro para ser duplicada
        ano_diaaberto = novo_diaaberto.ano 
        novo_roteiro = Roteiro(
            nome=f"{roteiro_original.nome} (Cópia {ano_diaaberto})" ,
            coordenadorID=roteiro_original.coordenadorID,
            diaabertoid_id=novo_diaaberto_id ,  # Atualiza o diaabertoID com o novo valor escolhido
            participantesmaximo=roteiro_original.participantesmaximo,
            duracaoesperada=roteiro_original.duracaoesperada,
            publicoalvo= roteiro_original.publicoalvo,
            descricao= roteiro_original.descricao
        )
        novo_roteiro.save()

        # Duplica as atividades do roteiro original para o novo roteiro
        atividades_original = Atividade.objects.filter(roteiro=roteiro_original)
        novas_atividades = []
        for atividade in atividades_original:
            atividade.pk = None
            atividade.roteiro = novo_roteiro
            atividade.save()
            novas_atividades.append(atividade)
        sessoes_original = Sessao.objects.filter(roteiroid=roteiro_original)
        for sessao in sessoes_original:
            sessao.pk = None
            sessao.roteiroid = novo_roteiro
            nova_data = adjust_session_date(sessao.dia, novo_diaaberto)
            sessao.dia = nova_data
            sessao.save()
        
        return redirect('roteiros:criarRoteiro')  # Assegura-se de que este é o nome correto da rota para criar um roteiro
    else:
        return render(request, 'mensagem.html', {
            'tipo': 'error',
            'm': 'Roteiro não encontrado ou você não tem permissão para duplicar este roteiro.'
        })

def adjust_session_date(original_date, novo_diaaberto):
    start_date = novo_diaaberto.datadiaabertoinicio.date()
    end_date = novo_diaaberto.datadiaabertofim.date()
    # Assuming original_date is also a date object.
    if start_date <= original_date <= end_date:
        return original_date
    return start_date 

@handle_db_errors
def alterarRoteiro(request,id):
    atividade = Atividade.objects.filter(id=id).first()
    roteiro = atividade.roteiro
    user_check_var = user_check(request=request, user_profile=[Coordenador])
    if user_check_var.get('exists') == False: return user_check_var.get('render')
    userId = user_check_var.get('firstProfile').utilizador_ptr_id

    if roteiro is not None:  
        roteiro_object = atividade.roteiro
        roteiro_object = Roteiro.objects.get(id=roteiro.id) 
        roteiro_object_form = RoteiroForm(instance=roteiro_object) 
        todas_atividades = Atividade.objects.all()
        selecionadas = Atividade.objects.filter(roteiro=roteiro_object).values_list('id', flat=True)
 
        if request.method == 'POST':  
            submited_data = request.POST.copy()
            roteiro_object_form = RoteiroForm(submited_data,instance=roteiro_object)
            
            if roteiro_object_form.is_valid():
               
                roteiro_object_formed = roteiro_object_form.save(commit=False) 
               
                atividades_ids = request.POST.getlist('atividades_ids')
                
                atividades_ids = [int(id) for id in atividades_ids] if atividades_ids else []

                atividades_selecionadas = Atividade.objects.filter(id__in=atividades_ids)
                maior_duracao = atividades_selecionadas.aggregate(maior_duracao=Max('duracaoesperada'))['maior_duracao']
                roteiro_object_formed.duracaoesperada = maior_duracao

                roteiro_object_formed.save()  # Salva as alterações feitas no roteiro.

              
                Atividade.objects.filter(roteiro=roteiro_object_formed).exclude(id__in=atividades_ids).update(roteiro=None)

                if atividades_ids:
                    Atividade.objects.filter(id__in=atividades_ids).update(roteiro=roteiro_object_formed)
                
                
                sessoes = Sessao.objects.filter(roteiroid = roteiro_object_formed)
                for sessao in sessoes:
                    inicio= str(sessao.horarioid.inicio)
                    splitinicio=inicio.split(":")
                    print(splitinicio)
                    duracaoesperada= roteiro_object_formed.duracaoesperada
                    hfim= horariofim(splitinicio,duracaoesperada)
                    horario= Horario.objects.filter(inicio= sessao.horarioid.inicio, fim=hfim).first()
                    if horario is None:
                        new_Horario= Horario(inicio=inicio, fim=hfim)
                        new_Horario.save()
                    else:
                        new_Horario= horario
                    sessao.horarioid=Horario.objects.get(id=new_Horario.id)
                    sessao.vagas = roteiro_object_formed.participantesmaximo
                    sessao.save()
            return redirect('roteiros:sessaoRoteiro',roteiro.id)
        else:
            #roteiro_object_form = RoteiroForm()
            atividades = Atividade.objects.all()  
            meio = len(atividades) // 2 
            return render(request=request,
                            template_name='roteiros/proporRoteiro.html',
                            context={'form': roteiro_object_form, 'atividades': todas_atividades,   'selecionadas':selecionadas}
                            )
    else:
        return    render(request=request,
                            template_name='mensagem.html',
                            context={
                                'tipo':'error',
                                'm':'Não tem permissões para esta ação!'
                            })
    

@handle_db_errors
def alterarRoteiro2(request,id):
    roteiro = Roteiro.objects.filter(id=id).first()
    user_check_var = user_check(request=request, user_profile=[Coordenador])
    if user_check_var.get('exists') == False: return user_check_var.get('render')
    userId = user_check_var.get('firstProfile').utilizador_ptr_id

    if roteiro is not None:  
        roteiro_object = roteiro
        roteiro_object = Roteiro.objects.get(id=roteiro.id) 
        roteiro_object_form = RoteiroForm(instance=roteiro_object) 
        todas_atividades = Atividade.objects.all()
        selecionadas = Atividade.objects.filter(roteiro=roteiro_object).values_list('id', flat=True)
 
        if request.method == 'POST':  
            submited_data = request.POST.copy()
            roteiro_object_form = RoteiroForm(submited_data,instance=roteiro_object)
            
            if roteiro_object_form.is_valid():
               
                roteiro_object_formed = roteiro_object_form.save(commit=False) 
               
                atividades_ids = request.POST.getlist('atividades_ids')
                
                atividades_ids = [int(id) for id in atividades_ids] if atividades_ids else []

                atividades_selecionadas = Atividade.objects.filter(id__in=atividades_ids)
                maior_duracao = atividades_selecionadas.aggregate(maior_duracao=Max('duracaoesperada'))['maior_duracao']
                roteiro_object_formed.duracaoesperada = maior_duracao

                roteiro_object_formed.save()  # Salva as alterações feitas no roteiro.

              
                Atividade.objects.filter(roteiro=roteiro_object_formed).exclude(id__in=atividades_ids).update(roteiro=None)

                if atividades_ids:
                    Atividade.objects.filter(id__in=atividades_ids).update(roteiro=roteiro_object_formed)
                
                
                sessoes = Sessao.objects.filter(roteiroid = roteiro_object_formed)
                for sessao in sessoes:
                    inicio= str(sessao.horarioid.inicio)
                    splitinicio=inicio.split(":")
                    print(splitinicio)
                    duracaoesperada= roteiro_object_formed.duracaoesperada
                    hfim= horariofim(splitinicio,duracaoesperada)
                    horario= Horario.objects.filter(inicio= sessao.horarioid.inicio, fim=hfim).first()
                    if horario is None:
                        new_Horario= Horario(inicio=inicio, fim=hfim)
                        new_Horario.save()
                    else:
                        new_Horario= horario
                    sessao.horarioid=Horario.objects.get(id=new_Horario.id)
                    sessao.vagas = roteiro_object_formed.participantesmaximo
                    sessao.save()
            return redirect('roteiros:sessaoRoteiro',id)
        else:
            #roteiro_object_form = RoteiroForm()
            atividades = Atividade.objects.all()  
            meio = len(atividades) // 2 
            return render(request=request,
                            template_name='roteiros/proporRoteiro.html',
                            context={'form': roteiro_object_form, 'atividades': todas_atividades, 'selecionadas':selecionadas}
                            )
    else:
        return    render(request=request,
                            template_name='mensagem.html',
                            context={
                                'tipo':'error',
                                'm':'Não tem permissões para esta ação!'
                            })
    
    
@handle_db_errors
def verRelatorio(request, id):
    # Check if the user has the required profile to view the report
    roteiros = get_object_or_404(Roteiro,pk=id)
    sessoes = Sessao.objects.filter(roteiroid=id)
    atividades = Atividade.objects.filter(roteiro=id)
    diaaberto = roteiros.diaabertoid
    ano_diaaberto = diaaberto.ano

    context ={
        'roteiro': roteiros, 
        'sessoes': sessoes,
        'atividades': atividades,
        'ano': ano_diaaberto
    }
    return render_pdf( 'roteiros/verRelatorio.html', context, f"roteiro_{roteiros.nome}.pdf") 




@handle_db_errors
def verTodosRelatorios(request):
    ano_atual = datetime.now().year
    dia_aberto_atual = Diaaberto.objects.filter(ano=ano_atual).first()


    if not dia_aberto_atual:
        return render(request, 'mensagem.html', {'tipo': 'error', 'm': 'Não há dia aberto para o ano atual.'})

    roteiros = Roteiro.objects.filter(diaabertoid=dia_aberto_atual)
    
    dados_roteiros = []
    atividades_todas = Atividade.objects.filter(roteiro__isnull=True, diaabertoid=dia_aberto_atual, estado='Aceite')

    if not roteiros.exists()  and not atividades_todas.exists():
        return render(request, 'mensagem.html', {'tipo': 'error', 'm': 'Não existe atividades nem roteiros associados a este dia Aberto.'})
    
    # Estrutura para armazenar atividades com suas sessões
    atividades_com_sessoes = []
    for atividade in atividades_todas:
        sessoes_atividade = Sessao.objects.filter(atividadeid=atividade.id)
        atividades_com_sessoes.append({
            'atividade': atividade,
            'sessoes': sessoes_atividade
        })

    for roteiro in roteiros:
        sessoes = Sessao.objects.filter(roteiroid=roteiro.id)
        atividades = Atividade.objects.filter(roteiro=roteiro.id)

        dados_roteiros.append({
            'roteiro': roteiro,
            'sessoes': sessoes,
            'atividades': atividades,
            
            'atividades_com_sessoes': atividades_com_sessoes  # Adicionado a lista de atividades com suas sessões
        })

    context = {
        'dados_roteiros': dados_roteiros,
        'ano': dia_aberto_atual.ano
    }

    return render_pdf('roteiros/verRelatorioTodos.html', context, "todos_roteiros.pdf")



@handle_db_errors
def eliminarRoteiro(request,id):
    user_check_var = user_check(request=request, user_profile=[Coordenador])
    if user_check_var.get('exists') == False: return user_check_var.get('render')
    roteiro = Roteiro.objects.filter(id=id)
    roteirocheck= roteiro.first()
    sessoes = Sessao.objects.filter(roteiroid=roteirocheck)
    for sessao in sessoes:
        if sessao.vagas != roteirocheck.participantesmaximo:
            return    render(request=request,
                            template_name='mensagem.html',
                            context={
                                'tipo':'error',
                                'm':'Não tem permissões para esta ação!'
                            })

    if roteiro.exists():
        #views.enviar_notificacao_automatica(request,"roteiroEliminado",id) #Enviar Notificacao Automatica !!!!!!
        roteiro.delete()
        return redirect('roteiros:criarRoteiro')
    else:
        return    render(request=request,
                            template_name='mensagem.html',
                            context={
                                'tipo':'error',
                                'm':'Não tem permissões para esta ação!'
                            })
    
    
@handle_db_errors    
def eliminarRoteiro2(request, id):
    user_check_var = user_check(request=request, user_profile=[Coordenador])
    if not user_check_var.get('exists'):
        return user_check_var.get('render')
    
    atividade = Atividade.objects.filter(id=id).first()
    if not atividade:
        return render(request=request,
                      template_name='mensagem.html',
                      context={'tipo': 'error', 'm': 'Atividade não encontrada!'})

    roteiro = atividade.roteiro
    if not roteiro:
        return render(request=request,
                      template_name='mensagem.html',
                      context={'tipo': 'error', 'm': 'Roteiro não encontrado!'})

    diaabertopropostas = Diaaberto.objects.filter(datapropostasatividadesincio__lte=now(),dataporpostaatividadesfim__gte=now()).first()   
    if diaabertopropostas:
       return render(request=request,
                      template_name='mensagem.html',
                      context={'tipo': 'error', 'm': 'O periodo de propor e eliminar roteiros ja terminou !'})


    dia_aberto = Diaaberto.objects.filter(datadiaabertoinicio__lte=now(), datadiaabertofim__gte=now()).first()
    if dia_aberto:
        return render(request=request,
                      template_name='mensagem.html',
                      context={'tipo': 'error', 'm': 'Não pode eliminar o roteiro enquanto o dia aberto está a decorrer!'})

    sessoes = Sessao.objects.filter(roteiroid=roteiro.id)
    for sessao in sessoes:
        if sessao.vagas != roteiro.participantesmaximo:
            return render(request=request,
                          template_name='mensagem.html',
                          context={'tipo': 'error', 'm': 'Não tem permissões para esta ação!'})

    if roteiro:
        # views.enviar_notificacao_automatica(request, "roteiroEliminado", id) # Enviar Notificação Automática
        roteiro.delete()
        return redirect('atividades:atividadesUOrganica')
    else:
        return render(request=request,
                      template_name='mensagem.html',
                      context={'tipo': 'error', 'm': 'Não tem permissões para esta ação!'})


        

  
   
    



    
            

