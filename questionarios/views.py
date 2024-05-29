from django.db import OperationalError
from django.shortcuts import get_object_or_404, redirect, render
from django.http import HttpRequest, HttpResponse, JsonResponse
from django.urls import reverse_lazy
from .forms import *
from .models import *
from utilizadores.models import *
from inscricoes.models import Inscricao, Inscricaosessao, Inscricaotransporte
from atividades.models import Tema
from datetime import datetime, timezone,date, time
from atividades.models import Sessao
from django.core.serializers import *
from django.db.models import Count, Q
import random
import json
from pip._vendor import requests
from django.core import serializers
from utilizadores.views import user_check
from questionarios.tables import QuestionarioTable, PerguntasTable
from questionarios.filters import QuestionarioFilter
from django_tables2 import SingleTableMixin, SingleTableView
from django_filters.views import FilterView
from django.db.models.query import QuerySet
from .forms import QuestionarioForm
from django.views.generic import ListView, CreateView

from .forms import QuestionarioForm, PerguntaForm, OpcaoForm;
from django.forms import inlineformset_factory
from django.shortcuts import render, redirect, get_object_or_404
from .models import Questionario, Pergunta, OpcaoP, EstadoQuestionario
from .forms import PerguntaForm, OpcaoForm
import json
from django.contrib import messages
from django.http import JsonResponse
from django.contrib.auth import get_user
from django.http import FileResponse
import io
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from reportlab.lib.units import inch
from django.shortcuts import redirect, get_object_or_404
from .models import Questionario, EstadoQuestionario
from django.http import JsonResponse
from django.core.mail import send_mail
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.models import User
from .models import Questionario
import json


def handle_db_errors(view_func):
    def wrapper(request, *args, **kwargs):
        try:
            return view_func(request, *args, **kwargs)
        except OperationalError as e:
            print(f"Database error encountered: {e}")
            return render(request, "db_error.html", status=503)
        except Exception as e:
            print(f"Unexpected error: {e}")
            return render(request, "db_error.html", status=503)
    return wrapper
# Create your views here.
#gustavo

class TimeC():
	time: str = None
	seconds: int = None
	time_split = None

	def __init__(self, time:str = None, time_as_seconds: int = None):
		if time is not None and time_as_seconds is not None:
			raise Exception('Only one argument can be set')
		if time is None and time_as_seconds is None:
			raise Exception('Either argument must be set')
		if time is not None:
			self.time = time
			self.time_split = str(time).split(':')
			self.seconds = int(self.time_split[0])*60*60 + int(self.time_split[1])*60
			self.__str__()
		else:
			self.time = str(int(time_as_seconds/60/60)) + ':' + str(int(time_as_seconds%3600))
			self.seconds = time_as_seconds
			self.time_split = self.time.split(':')
			self.__str__()


	def __add__(self, other):
		time_s = other.seconds
		time_sum = self.seconds+time_s
		if time_sum >= 86400:
			time_sum-=86400
		return TimeC(time_as_seconds=time_sum)

	def __sub__(self, other):
		time_s = other.seconds
		time_sub = self.seconds-time_s
		if time_sub < 0:
			time_sub=0
		return TimeC(time_as_seconds=time_sub)

	def __str__(self):
		if (len(self.time_split[0]) == 1): time_start = '0' + str(self.time_split[0]) 
		else: time_start = self.time_split[0]
		if (len(self.time_split[1]) == 1): time_end =  self.time_split[1] + '0'
		else: time_end =  self.time_split[1]
		self.time= time_start+':'+time_end
		return self.time

	def __eq__(self, other):
		return other.__str__() == self.__str__()
	def __lt__(self, other):
		return self.seconds < other.seconds
	def __gt__(self, other):
		return self.seconds > other.seconds
	def __le__(self, other):
		return self.seconds <= other.seconds
	def __ge__(self, other):
		return self.seconds >= other.seconds	
	def __ne__(self, other):
		return not self.__eq__(self,other=other)
     
	
class ListaQuestionarios(SingleTableMixin, FilterView):
    model = Questionario
    table_class = QuestionarioTable
    filterset_class = QuestionarioFilter
    template_name = 'questionarios/lista_questionarios.html'

    def get_queryset(self):
        validar_publicados(self.request)
        # Obtém o queryset original
        queryset = super().get_queryset()
        
        # Aqui você pode adicionar lógica adicional para processar outros parâmetros do request,
        # como a ordenação baseada em 'ordenacao_data' que o usuário escolher no formulário.
        # Supondo que 'ordenacao_data' seja o nome do campo no seu formulário para a ordenação.
        # Pega o estado do filtro a partir da query string
        estado = self.request.GET.get('estado')

        # Se o estado não é especificamente 'arq' (arquivado), exclua os arquivados da lista
        if estado != 'arq':
            queryset = queryset.exclude(estado__id='arq')
        
        ordenacao_data = self.request.GET.get('ordenacao_data')
        if ordenacao_data == 'mais_recente':
            queryset = queryset.order_by('data_publicada')
        elif ordenacao_data == 'mais_antigo':
            queryset = queryset.order_by('-data_publicada')

        return queryset
    
@handle_db_errors
def criarQuestionario(request):
    if request.method == 'POST':
        form = QuestionarioForm(request.POST)
        if form.is_valid():
            questionario = form.save(commit=False)
            
            # Associe o questionário ao administrador, como antes
            administrador, created = Administrador.objects.get_or_create(utilizador_ptr_id=request.user)
            questionario.autor = administrador

            estado_pen = EstadoQuestionario.objects.get(id='pen')  # Obtenha o estado 'pen' do banco de dados
            questionario.estado = estado_pen  # Associe esse estado ao questionário
            
            questionario.save()
            
            # Novo: Associe os dias abertos selecionados ao questionário
            dias_abertos_selecionados = form.cleaned_data['dias_abertos']
            for dia_aberto in dias_abertos_selecionados:
                # Supondo uma relação ManyToMany
                questionario.dias_abertos.add(dia_aberto)
            
            # Após adicionar os dias abertos, você pode salvar novamente, se necessário
            # questionario.save()

            # Redirecione para a próxima etapa
            return redirect('questionarios:inserirPerguntas', questionario.id)
    else:
        form = QuestionarioForm()

    return render(request, 'questionarios/criar_questionario.html', {'form': form})
@handle_db_errors
def editarQuestionario(request, id):
    questionario = get_object_or_404(Questionario, pk=id)
    if request.method == 'POST':
        form = QuestionarioForm(request.POST, instance=questionario)
        if form.is_valid():
            # Salva as mudanças no questionário sem commitar para o banco de dados ainda
            questionario = form.save(commit=False)
            questionario.save()  # Aqui você precisa salvar antes de definir as relações many-to-many

            # Atualiza a relação many-to-many com os Dias Abertos selecionados
            # Isto limpa todas as associações existentes e adiciona as novas, refletindo exatamente o estado do formulário.
            questionario.dias_abertos.set(form.cleaned_data['dias_abertos'])

            # Após configurar os dias abertos, você pode redirecionar para onde precisar
            return redirect('questionarios:inserirPerguntas', questionario.id)
    else:
        form = QuestionarioForm(instance=questionario)

    return render(request, 'questionarios/editar_questionarios.html', {'form': form})

@handle_db_errors
def deletarQuestionario(request, id):
	user_check_var = user_check(request=request, user_profile=[Administrador])
	if user_check_var.get('exists') == False: return user_check_var.get('render')

	if id is not None:
		questionario = Questionario.objects.filter(id=id)
		questionario.delete()
	return redirect('questionarios:lista_questionarios')


@handle_db_errors
def inserirPerguntas(request, id):
    # Verificação de permissão (assumindo que você tem uma função similar à user_check)
    user_check_var = user_check(request=request, user_profile=[Administrador])
    if not user_check_var.get('exists'):
        return user_check_var.get('render')

    # Obter o questionário pelo ID fornecido
    try:
        questionario = Questionario.objects.get(id=id)
    except Questionario.DoesNotExist:
        return render(request, 'mensagem.html', {
            'tipo': 'error',
            'mensagem': 'Questionário não encontrado!'
        })

    if request.method == "POST":
        form = PerguntaForm(request.POST)
        if form.is_valid():
            pergunta = form.save(commit=False)
            pergunta.questionario = questionario  # associa a pergunta ao questionário
            pergunta.save()
            messages.success(request, 'Pergunta adicionada com sucesso!')

            opcoes_json = request.POST.get('opcoes')
            if opcoes_json:
                opcoes = json.loads(opcoes_json)
                for texto_opcao in opcoes:
                    OpcaoP.objects.create(pergunta=pergunta, texto_opcao=texto_opcao)


            return redirect('questionarios:inserirPerguntas', id=id)
    else:
        form = PerguntaForm()

    return render(request, 'questionarios/inserir_perguntas.html', {
        'form': form,
        'id': id,
        'perguntas_quest': Pergunta.objects.filter(questionario_id=id).select_related('tema')
    })

@handle_db_errors
def eliminarPergunta(request, id):
    user_check_var = user_check(request=request, user_profile=[Administrador])
    if not user_check_var.get('exists'):
        return user_check_var.get('render')

    try:
        pergunta = Pergunta.objects.get(id=id)  # Usa get() ao invés de filter() para capturar a exceção se não existir
        questionario_id = pergunta.questionario.id  # Mantém o ID para redirecionamento
        pergunta.delete()  # Deleta a pergunta

        # Redireciona para a página de inserção de pergunta, com o ID do questionário
        return redirect('questionarios:inserirPerguntas', id=questionario_id)
    except Pergunta.DoesNotExist:
        # Se a pergunta não existir, renderiza a página de erro
        return render(request, 'mensagem.html', {
            'tipo': 'error',
            'm': 'A pergunta não foi encontrada ou você não tem permissão para realizar esta ação!'
        })
    

@handle_db_errors
def editar_pergunta(request, id):
    pergunta = get_object_or_404(Pergunta, id=id)

    if request.method == 'POST':
        form = PerguntaForm(request.POST, instance=pergunta)
        if form.is_valid():
            # Antes da atualização, verifica e elimina se necessário
            tipo_resposta_original = pergunta.tipo_resposta
            pergunta_atualizada = form.save(commit=False)  # Salva temporariamente sem commit

            if tipo_resposta_original == 'multipla_escolha' and pergunta_atualizada.tipo_resposta != 'multipla_escolha':
                print(f"Deleting options for question {id}")
                OpcaoP.objects.filter(pergunta=id).delete()

            pergunta_atualizada.save()  # Commit das alterações da pergunta

            if pergunta_atualizada.tipo_resposta == 'multipla_escolha':
                if tipo_resposta_original == pergunta_atualizada.tipo_resposta:
                    OpcaoP.objects.filter(pergunta=id).delete()
                opcoes_novas = request.POST.getlist('opcoes')
                for texto_opcao in opcoes_novas:
                    if texto_opcao:
                        OpcaoP.objects.create(pergunta=pergunta_atualizada, texto_opcao=texto_opcao)

            messages.success(request, 'Pergunta atualizada com sucesso!')
            return redirect('questionarios:inserirPerguntas', id=pergunta.questionario.id)
    else:
        form = PerguntaForm(instance=pergunta)

    return render(request, 'questionarios/editar_perguntas.html', {'form': form, 'pergunta': pergunta})


def verificar_temas(questionario):
    temas = set()
    get_perguntas = Pergunta.objects.filter(questionario=questionario)
    for pergunta in get_perguntas:
        tema_atual = pergunta.tema.tema.strip() 
        print(tema_atual) # Asegura a remoção de espaços extras
        temas.add(tema_atual)

    tem_almoco = "Almoço" in temas
    tem_transportes = "Transporte" in temas
    tem_atividade = "Atividade" in temas
    tem_dia_aberto = "Dia Aberto" in temas

    if tem_almoco and tem_transportes and tem_atividade and tem_dia_aberto:
        tema_texto = "Almoço, Atividade, Dia Aberto e Transporte"
    elif tem_almoco and tem_transportes and tem_atividade:
        tema_texto = "Almoço, Atividade e Transporte"
    elif tem_almoco and tem_dia_aberto and tem_atividade:
        tema_texto = "Almoço, Atividade e Dia Aberto"
    elif tem_almoco and tem_transportes and tem_dia_aberto:
        tema_texto = "Almoço, Dia Aberto e Transporte"
    elif tem_dia_aberto and tem_transportes and tem_atividade:
        tema_texto = "Atividade, Dia Aberto e Transporte"
    elif tem_almoco and tem_transportes:
        tema_texto = "Almoço e Transporte"
    elif tem_almoco and tem_atividade:
        tema_texto = "Almoço e Atividade"
    elif tem_dia_aberto and tem_almoco:
        tema_texto = "Almoço e Dia Aberto"
    elif tem_atividade and tem_transportes:
        tema_texto = "Atividade e Transporte"
    elif tem_dia_aberto and tem_atividade:
        tema_texto = "Atividade e Dia Aberto"
    elif tem_dia_aberto and tem_transportes:
        tema_texto = "Transporte e Dia Aberto"
    elif tem_almoco:
        tema_texto = "Almoço"
    elif tem_transportes:
        tema_texto = "Transporte"
    elif tem_atividade:
        tema_texto = "Atividade"
    elif tem_dia_aberto:
        tema_texto = "Dia Aberto"
    else:
        tema_texto = "Nenhum tema disponível"

    return temas, tema_texto

##################### GUSTAVO ##############################################
'''

@handle_db_errors
def consultarQuestionario(request, id):
    user = get_user(request)
    if user.groups.filter(name="Administrador").exists():
        try:
            questionario = Questionario.objects.get(id=id)
            nome = questionario.nome
            autor = questionario.autor
            data_publicacao = questionario.data_publicada
            data_expiracao = questionario.data_fim_publicacao
            print(data_expiracao)
            estado = questionario.estado.nome

            perguntas = []
            temas, tema_texto = verificar_temas(questionario)

            get_perguntas = Pergunta.objects.filter(questionario=questionario)
            for pergunta in get_perguntas:
                perg = {
                    'texto': pergunta.texto,
                    'tipo_resposta': pergunta.tipo_resposta,
                    'tema': pergunta.tema.tema.strip()
                }

                if pergunta.tipo_resposta == "multipla_escolha":
                    escolhas = []
                    get_escolhas = OpcaoP.objects.filter(pergunta=pergunta.pk)
                    for escolha in get_escolhas:
                        escolhas.append({'texto_opcao': escolha.texto_opcao})
                    perg['opcoes'] = escolhas

                perguntas.append(perg)

            return render(request, 'questionarios/consultar_questionario.html', {
                'perguntas': perguntas,
                'nome': nome,
                'autor': autor,
                'data_publicacao': data_publicacao,
                'data_expiracao': data_expiracao,
                'estado': estado,
                'tema_texto': tema_texto,
                'data_atual': datetime.now().date(), #data de hoje
                'id': id
            })
        except Questionario.DoesNotExist:
            # Tratar o caso em que o questionário não existe
            return redirect('utilizadores:mensagem',7001) #O questionario solicitado não existe
    else:
        # Tratar caso o usuário não seja um administrador
        return redirect('utilizadores:mensagem',7000) #O Utilizador não possui permissoões para consultar um questionario
'''

from django.core.paginator import Paginator
from django.shortcuts import render, redirect, get_object_or_404
from .models import Questionario, Pergunta, OpcaoP
from django.utils.timezone import now
from django.contrib.auth.decorators import login_required
from django.db import transaction

@login_required
@handle_db_errors
@transaction.atomic
def consultarQuestionario(request, id):
    user = get_user(request)
    if user.groups.filter(name="Administrador").exists():
        try:
            questionario = Questionario.objects.get(id=id)
            nome = questionario.nome
            autor = questionario.autor
            data_publicacao = questionario.data_publicada
            data_expiracao = questionario.data_fim_publicacao
            estado = questionario.estado.nome

            perguntas_list = Pergunta.objects.filter(questionario=questionario)
            paginator = Paginator(perguntas_list, 3)  # 5 perguntas por página
            page_number = request.GET.get('page')
            perguntas_paginated = paginator.get_page(page_number)

            perguntas = []
            temas, tema_texto = verificar_temas(questionario)  # Supõe-se que verificar_temas é uma função existente

            for pergunta in perguntas_paginated:
                perg = {
                    'texto': pergunta.texto,
                    'tipo_resposta': pergunta.tipo_resposta,
                    'tema': pergunta.tema.tema.strip()
                }

                if pergunta.tipo_resposta == "multipla_escolha":
                    escolhas = []
                    get_escolhas = OpcaoP.objects.filter(pergunta=pergunta.pk)
                    for escolha in get_escolhas:
                        escolhas.append({'texto_opcao': escolha.texto_opcao})
                    perg['opcoes'] = escolhas

                perguntas.append(perg)

            return render(request, 'questionarios/consultar_questionario.html', {
                'perguntas': perguntas,
                'nome': nome,
                'autor': autor,
                'data_publicacao': data_publicacao,
                'data_expiracao': data_expiracao,
                'estado': estado,
                'tema_texto': tema_texto,
                'data_atual': now().date(),
                'id': id,
                'pagina': perguntas_paginated
            })
        except Questionario.DoesNotExist:
            return redirect('utilizadores:mensagem', 7001)  # O questionário solicitado não existe
    else:
        return redirect('utilizadores:mensagem', 7000)  # O usuário não possui permissões para consultar um questionário

    
@handle_db_errors
def validarQuestionario(request, id):
    #user_check_var = user_check(request=request, user_profile=[Administrador])
    #if not user_check_var.get('exists'):
       # return user_check_var.get('render')
    user = get_user(request)
    if user.groups.filter(name = "Administrador").exists():

        # Obtenha o questionário com o ID fornecido
        questionario = get_object_or_404(Questionario, id=id)

        if questionario.estado.id == 'pen' or questionario.estado.id == 'ind':
            estado_indisponivel = EstadoQuestionario.objects.get(id='dis')

            # Atualize o estado do questionário para 'indisponível'
            questionario.estado = estado_indisponivel
            questionario.save()

            # Chame a função consultarQuestionario para renderizar a página de consulta atualizada
            return redirect('questionarios:lista_questionarios')
        else:
            return redirect('utilizadores:mensagem',7003) #O questionario solicitado não pode ser Validado
    else:
        return redirect('utilizadores:mensagem',7002) #O Utilizador não possui permissoões para validar um questionario
    
from django.utils.timezone import now
@handle_db_errors
def validar_publicados(request):
    if request.user.groups.filter(name="Administrador").exists():
        questionarios = Questionario.objects.filter(estado__id='pub', data_fim_publicacao__lt=now().date())
        estado_indisponivel = EstadoQuestionario.objects.get(id='dis')
        for questionario in questionarios:
            questionario.estado = estado_indisponivel
            questionario.save()
@handle_db_errors   
def rejeitarQuestionario(request, id):
    #user_check_var = user_check(request=request, user_profile=[Administrador])
    #if not user_check_var.get('exists'):
       # return user_check_var.get('render')
    user = get_user(request)
    if user.groups.filter(name = "Administrador").exists():

        # Obtenha o questionário com o ID fornecido
        questionario = get_object_or_404(Questionario, id=id)

        if questionario.estado.id == 'pen':
            estado_indisponivel = EstadoQuestionario.objects.get(id='ind')

            # Atualize o estado do questionário para 'indisponível'
            questionario.estado = estado_indisponivel
            questionario.save()

            # Chame a função consultarQuestionario para renderizar a página de consulta atualizada
            return redirect('questionarios:lista_questionarios')
        else:
            return redirect('utilizadores:mensagem',7005) #O questionario solicitado não pode ser Rejeitado
    else:
        return redirect('utilizadores:mensagem',7004) #O Utilizador não possui permissoões para rejeitar um questionario
@handle_db_errors
def publicarQuestionario(request, id):
    #user_check_var = user_check(request=request, user_profile=[Administrador])
    #if not user_check_var.get('exists'):
       # return user_check_var.get('render')
    user = get_user(request)
    if user.groups.filter(name = "Administrador").exists():

        # Obtenha o questionário com o ID fornecido
        questionario = get_object_or_404(Questionario, id=id)
        data_atual = datetime.now().date()
        if questionario.estado.id == 'dis':
            if questionario.data_fim_publicacao > data_atual:
                estado_indisponivel = EstadoQuestionario.objects.get(id='pub')

                # Atualize o estado do questionário para 'indisponível'
                questionario.estado = estado_indisponivel
                questionario.save()

                # Chame a função consultarQuestionario para renderizar a página de consulta atualizada
                return redirect('questionarios:lista_questionarios')
            else:
                 return redirect('utilizadores:mensagem',7008) #O Questionário não pode ser publicado pois o período de publicação ja passou
        else:
            return redirect('utilizadores:mensagem',7007)#O questionario solicitado não pode ser Publicado
    else:
        return redirect('utilizadores:mensagem',7006) #O utilizador não possui permissões para publicar um questionario
@handle_db_errors    
def despublicarQuestionario(request, id):
    #user_check_var = user_check(request=request, user_profile=[Administrador])
    #if not user_check_var.get('exists'):
       # return user_check_var.get('render')
    user = get_user(request)
    if user.groups.filter(name = "Administrador").exists():

        # Obtenha o questionário com o ID fornecido
        questionario = get_object_or_404(Questionario, id=id)
        if questionario.estado.id == 'pub':
            estado_indisponivel = EstadoQuestionario.objects.get(id='dis')

            # Atualize o estado do questionário para 'indisponível'
            questionario.estado = estado_indisponivel
            questionario.save()

            # Chame a função consultarQuestionario para renderizar a página de consulta atualizada
            return redirect('questionarios:lista_questionarios')
        else:
            return redirect('utilizadores:mensagem',7010)
    else:
        return redirect('utilizadores:mensagem',7009)
        
@handle_db_errors
def arquivarQuestionario(request, id):
    if request.user.groups.filter(name="Administrador").exists():
        questionario = get_object_or_404(Questionario, id=id)
        if questionario.estado.id != 'arq' and questionario.estado.id != 'pub':  # Adiciona verificação para o estado publicado
            questionario.arquivar()
            return redirect('questionarios:lista_questionarios')
        else:
            return redirect('utilizadores:mensagem',7012)
    else:
        return redirect('utilizadores:mensagem',7011)

@handle_db_errors
def desarquivarQuestionario(request, id):
    if request.user.groups.filter(name="Administrador").exists():
        questionario = get_object_or_404(Questionario, id=id)
        if questionario.estado_anterior and questionario.estado.id == 'arq' and questionario.estado_anterior.id != 'pub':
            questionario.desarquivar()
            return redirect('questionarios:lista_questionarios')
        else:
            return redirect('utilizadores:mensagem',7014)
    else:
        return redirect('utilizadores:mensagem',7013)
       
def draw_watermark(c):
    c.saveState()
    c.setFont("Helvetica", 200)
    c.setFillColorRGB(0.6, 0.6, 0.6, alpha=0.5)
    width, height = letter
    c.translate(width / 2 - 50, height / 2 + 50)
    c.rotate(45)
    c.drawCentredString(0, 0, "Draft")
    c.restoreState()
@handle_db_errors
def exportar_questionarios_draft_pdf(request, id):
    user = get_user(request)
    if user.groups.filter(name = "Administrador").exists():
        buf = io.BytesIO()
        c = canvas.Canvas(buf, pagesize=letter, bottomup=0)
        textob = c.beginText()
        textob.setTextOrigin(inch, inch)
        textob.setFont("Helvetica", 14)

        questionario = get_object_or_404(Questionario, id=id)
        temas = TemaQ.objects.filter(pergunta__questionario=questionario).distinct().order_by('tema')

        max_atividades_count = Inscricaosessao.objects.values('inscricao_id').annotate(count=Count('sessao')).order_by('-count').first()['count']

        tema_text = ', '.join([clean_string(tema.tema) for tema in temas])
        lines = [
            "Questionário: " + clean_string(questionario.nome),
            "Tema(s): " + tema_text,
            "Data de Publicação: " + questionario.data_publicada.strftime('%d/%m/%Y'),
            "Data de Expiração: " + questionario.data_fim_publicacao.strftime('%d/%m/%Y'),
            "------------------------------------------------------------------------------------------------------"
        ]

        for tema in temas:
            perguntas = Pergunta.objects.filter(questionario=questionario, tema=tema).order_by('id')
            if perguntas.exists():
                lines.append(f"Tema: {clean_string(tema.tema)}")
                lines.append("")
                counter = 1
                for pergunta in perguntas:
                    if pergunta.tema.tema == "Atividade":
                        for i in range(max_atividades_count):
                            lines.append(f"{counter}º Pergunta (Atividade {i+1}): {clean_string(pergunta.texto)}")
                            lines.append("")
                            lines.append("Atividade:_____________")
                            lines.append("")
                            if pergunta.tipo_resposta == "multipla_escolha":
                                opcoes = OpcaoP.objects.filter(pergunta=pergunta).order_by('id')
                                number_opcao = 1
                                for opcao in opcoes:
                                    lines.append(f"Opção {number_opcao}) {clean_string(opcao.texto_opcao)}")
                                    number_opcao += 1
                            else:
                                lines.append("R: _____________________________________________________________")
                            lines.append("")
                    else:
                        lines.append(f"{counter}º Pergunta: {clean_string(pergunta.texto)}")
                        if pergunta.tipo_resposta == "multipla_escolha":
                            lines.append("")
                            opcoes = OpcaoP.objects.filter(pergunta=pergunta).order_by('id')
                            number_opcao = 1
                            for opcao in opcoes:
                                lines.append(f"Opção {number_opcao}) {clean_string(opcao.texto_opcao)}")
                                number_opcao += 1
                        else:
                            lines.append("")
                            lines.append("R: _____________________________________________________________")
                        lines.append("")
                    counter += 1
                lines.append("------------------------------------------------------------------------------------------------------")

        number_lines = 0
        for line in lines:
            if number_lines == 40:
                c.drawText(textob)
                draw_watermark(c)  # Draw draft text before showing a new page
                c.showPage()
                textob = c.beginText()
                textob.setTextOrigin(inch, inch)
                textob.setFont("Helvetica", 14)
                number_lines = 0
            textob.textLine(line)
            number_lines += 1

        c.drawText(textob)
        draw_watermark(c)  # Draw draft text on the last page
        c.showPage()
        c.save()
        buf.seek(0)
        return FileResponse(buf, as_attachment=True, filename=f"questionario_{slugify(questionario.nome)}.pdf")
    else:
        return redirect('utilizadores:mensagem',7015)



def clean_string(text):
    """Clean string to remove non-printable characters and strip leading/trailing spaces."""
    return re.sub(r'[\x00-\x1f\x7f-\x9f]+', '', text.strip())
@handle_db_errors
def exportar_questionarios_pdf(request, id):
    user = get_user(request)
    if user.groups.filter(name = "Administrador").exists():
        buf = io.BytesIO()
        c = canvas.Canvas(buf, pagesize=letter, bottomup=0)
        textob = c.beginText()
        textob.setTextOrigin(inch, inch)
        textob.setFont("Helvetica", 14)

        questionario = get_object_or_404(Questionario, id=id)
        temas = TemaQ.objects.filter(pergunta__questionario=questionario).distinct().order_by('tema')

        # Calculando o número máximo de atividades por inscrição
        max_atividades_count = Inscricaosessao.objects.values('inscricao_id').annotate(count=Count('sessao')).order_by('-count').first()['count']

        tema_text = ', '.join([clean_string(tema.tema) for tema in temas])
        lines = [
            "Questionário: " + clean_string(questionario.nome),
            "Tema(s): " + tema_text,
            "Data de Publicação: " + questionario.data_publicada.strftime('%d/%m/%Y'),
            "Data de Expiração: " + questionario.data_fim_publicacao.strftime('%d/%m/%Y'),
            "------------------------------------------------------------------------------------------------------"
        ]

        for tema in temas:
            perguntas = Pergunta.objects.filter(questionario=questionario, tema=tema).order_by('id')
            if perguntas.exists():
                lines.append(f"Tema: {clean_string(tema.tema)}")
                lines.append("")
                counter = 1
                for pergunta in perguntas:
                    if pergunta.tema.tema == "Atividade":
                        for i in range(max_atividades_count):
                            lines.append(f"{counter}º Pergunta (Atividade {i+1}): {clean_string(pergunta.texto)}")
                            lines.append("")
                            lines.append("Atividade:_____________")
                            lines.append("")
                            if pergunta.tipo_resposta == "multipla_escolha":
                                opcoes = OpcaoP.objects.filter(pergunta=pergunta).order_by('id')
                                number_opcao = 1
                                for opcao in opcoes:
                                    lines.append(f"Opção {number_opcao}) {clean_string(opcao.texto_opcao)}")
                                    number_opcao += 1
                            else:
                                lines.append("R: _____________________________________________________________")
                            lines.append("")
                    else:
                        lines.append(f"{counter}º Pergunta: {clean_string(pergunta.texto)}")
                        if pergunta.tipo_resposta == "multipla_escolha":
                            lines.append("")
                            opcoes = OpcaoP.objects.filter(pergunta=pergunta).order_by('id')
                            number_opcao = 1
                            for opcao in opcoes:
                                lines.append(f"Opção {number_opcao}) {clean_string(opcao.texto_opcao)}")
                                number_opcao += 1
                        else:
                            lines.append("")
                            lines.append("R: _____________________________________________________________")
                        lines.append("")
                    counter += 1
                lines.append("------------------------------------------------------------------------------------------------------")

        number_lines = 0
        for line in lines:
            if number_lines == 40:
                c.drawText(textob)
                c.showPage()
                textob = c.beginText()
                textob.setTextOrigin(inch, inch)
                textob.setFont("Helvetica", 14)
                number_lines = 0
            
            textob.textLine(line)
            number_lines += 1

        c.drawText(textob)
        c.showPage()
        c.save()
        buf.seek(0)
        return FileResponse(buf, as_attachment=True, filename=f"questionario_{slugify(questionario.nome)}.pdf")
    else:
        return redirect('utilizadores:mensagem',7016)
@handle_db_errors
@csrf_exempt
def enviar_motivo_rejeicao(request, id):
    if request.method == 'POST':
        data = json.loads(request.body)
        motivo = data.get('motivo', '')

        try:
            # Buscar o questionário pelo ID
            questionario = Questionario.objects.get(pk=id)
            autor_id = questionario.autor_id  # Usando o campo autor_id para referenciar diretamente
            print(autor_id)

            # Buscar o usuário do Django correspondente
            autor = User.objects.get(pk=autor_id)
            print(autor)
            print(autor.email)

            # Enviar e-mail para o autor do questionário
            send_mail(
                'Motivo da Rejeição do Questionário',
                motivo,
                'a69845@ualg.pt',  
                [autor.email],  # E-mail do autor
                fail_silently=False,
            )
            return JsonResponse({'success': True})
        except Questionario.DoesNotExist:
            return JsonResponse({'error': 'Questionário não encontrado'}, status=404)
        except User.DoesNotExist:
            return JsonResponse({'error': 'Usuário não encontrado'}, status=404)
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)
    else:
        return JsonResponse({'error': 'Método não permitido'}, status=405)
@handle_db_errors
@csrf_exempt
def reverterIndisponivel(request, id):
    if request.method == 'POST':
        data = json.loads(request.body)
        motivo = data.get('motivo', '')

        user = get_user(request)
        if user.groups.filter(name="Administrador").exists():
            questionario = get_object_or_404(Questionario, id=id)
            if questionario.estado.id == 'ind':
                estado_pendente = EstadoQuestionario.objects.get(id='pen')
                questionario.estado = estado_pendente
                questionario.save()

                # Enviar o motivo por e-mail ao autor do questionário
                autor = questionario.autor.utilizador_ptr
                send_mail(
                    'Reversão do Questionário para Pendente',
                    motivo,
                    'a69845@ualg.pt',
                    [autor.email],
                    fail_silently=False,
                )
                return JsonResponse({'success': True})

            return JsonResponse({'error': 'O questionário não está indisponível'}, status=400)
        else:
            return JsonResponse({'error': 'Acesso negado'}, status=403)

    return JsonResponse({'error': 'Método não permitido'}, status=405)   

#############################################################################

#NAO TA SENDO USADO
@handle_db_errors
def desvalidarQuestionario(request, id):
    #user_check_var = user_check(request=request, user_profile=[Administrador])
    #if not user_check_var.get('exists'):
       # return user_check_var.get('render')
    user = get_user(request)
    if user.groups.filter(name = "Administrador").exists():

        # Obtenha o questionário com o ID fornecido
        questionario = get_object_or_404(Questionario, id=id)
        if questionario.estado.id == 'dis':
            estado_indisponivel = EstadoQuestionario.objects.get(id='pen')

            # Atualize o estado do questionário para 'indisponível'
            questionario.estado = estado_indisponivel
            questionario.save()

            # Chame a função consultarQuestionario para renderizar a página de consulta atualizada
            return redirect('questionarios:lista_questionarios')
        else:
             return redirect('utilizadores:mensagem',1006)