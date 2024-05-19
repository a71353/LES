
from .models import *
from utilizadores.views import user_check
from .tables import QuestionarioTable
from django_tables2 import SingleTableMixin, SingleTableView
from django_filters.views import FilterView
from questionarios.models import Questionario
import json
from django.shortcuts import get_object_or_404, redirect, render
from django.http import HttpRequest, HttpResponse
from django.urls import reverse_lazy
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
from .tables import QuestionarioTable
from django_tables2 import SingleTableMixin, SingleTableView
from django_filters.views import FilterView
from django.db.models.query import QuerySet
from django.views.generic import ListView, CreateView

from django.forms import inlineformset_factory
from django.shortcuts import render, redirect, get_object_or_404
import json
import datetime
from questionarios.models import * 
#gustavo
from django.contrib import messages
from django.contrib.auth import *
from django.shortcuts import redirect, get_object_or_404
from .models import Resposta, Resposta_Individual

from django.http import JsonResponse
from datetime import datetime
from configuracao.models import *

# Create your views here.
class ListaQuestionarios(SingleTableMixin, FilterView):
    model = Questionario  # Define o modelo a partir do qual buscar os dados.
    table_class = QuestionarioTable  # Define a classe da tabela para renderizar os dados.
    template_name = 'questionarios/listar_questionarios.html'  # Define o template a ser usado.

    def get_queryset(self):
        querySet = Questionario.objects.filter(estado=EstadoQuestionario.objects.get(id="pub"))
        for questionario in querySet:
            user_id= self.request.user.id
            #if Resposta.objects.filter(questionario=Questionario.objects.get(id=questionario.id), utilizador=Utilizador.objects.get(id=user_id)).exists():
                #querySet = querySet.exclude(id=questionario.id)
            
                
        return querySet
    

def typeOfUser(user):
    id = 0
    if( user.groups.filter(name="Coordenador").exists()):
        id = 1
    elif( user.groups.filter(name="Participante").exists()):
        id = 2
    elif( user.groups.filter(name="ProfessorUniversitario").exists()):
        id = 3
    elif( user.groups.filter(name="Administrador").exists()):
        id = 4
    elif( user.groups.filter(name="Colaborador").exists()):
        id = 5
    return id

''' SEM ORDENACAO DE TEMAS
def responderQuestionario(request, id):
    questionario = Questionario.objects.get(id=id)
    perguntas = Pergunta.objects.filter(questionario=id).all()
    opcoes = []
    user = get_user(request)
    #if user and user.is_authenticated:
        #return redirect('utilizadores:mensagem',1000)  # Redireciona o usuário para outra página se ele já tiver respondido
    
    if user.groups.filter(name="Participante").exists():
        if request.method == 'POST':
            resposta = Resposta.objects.create(
                questionario=questionario,
                data = datetime.now()
            )
            for pergunta in perguntas:
                resposta_texto = request.POST.get(f"respostas[{pergunta.id}]")
                resposta_individual = Resposta_Individual.objects.create(
                    resposta=resposta,
                    tipo_pergunta = pergunta.tipo_resposta,
                    pergunta=pergunta,
                    resposta_texto = resposta_texto
                )            
            return redirect('utilizadores:mensagem',1010)

        else:
            for pergunta in perguntas:
                if pergunta.tipo_resposta == 'multipla_escolha':
                    opcao = OpcaoP.objects.filter(pergunta=pergunta.id).all()
                    opcoes.append(opcao)

        return render(request, 'questionarios/responder_questionario.html', {'questionario': questionario,'perguntas': perguntas, 'opcoes': opcoes})

    else: # N é participantes
        return redirect('utilizadores:mensagem',1009)
'''

def responderQuestionario(request, id):
    questionario = Questionario.objects.get(id=id)
    perguntas = Pergunta.objects.filter(questionario=id).order_by('tema__tema', 'id').select_related('tema')
    user = get_user(request)

    codigo_inscricao = request.session.get('codigo_inscricao', None)
    inscricao = Inscricao.objects.get(codigo=codigo_inscricao)
    sessoes = Inscricaosessao.objects.filter(inscricao=inscricao)
    atividades = [sessao.sessao.atividadeid for sessao in sessoes]

    if user.groups.filter(name="Participante").exists():
        if request.method == 'POST':
            resposta = Resposta.objects.create(questionario=questionario, data=datetime.now(), codigo=codigo_inscricao)
            for pergunta in perguntas:
                # Trata perguntas vinculadas a atividades
                if pergunta.tema.tema == "Atividade":
                    for atividade in atividades:
                        resposta_texto = request.POST.get(f"respostas[{pergunta.id}_{atividade.id}]")
                        if resposta_texto:
                            Resposta_Individual.objects.create(
                                resposta=resposta, 
                                tipo_pergunta=pergunta.tipo_resposta, 
                                pergunta=pergunta, 
                                resposta_texto=resposta_texto,
                                atividade_id=atividade.id
                            )
                else:
                    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
                    resposta_texto = request.POST.get(f"respostas[{pergunta.id}_]")
                    print(resposta_texto)
                    if resposta_texto:
                        Resposta_Individual.objects.create(
                            resposta=resposta, 
                            tipo_pergunta=pergunta.tipo_resposta, 
                            pergunta=pergunta, 
                            resposta_texto=resposta_texto
                        )
            return redirect('utilizadores:mensagem', 8001)
        else:
            perguntas_por_tema = {}
            opcoes = []
            for pergunta in perguntas:
                tema = pergunta.tema.tema
                if tema not in perguntas_por_tema:
                    perguntas_por_tema[tema] = []
                if tema == "Atividade":
                    for atividade in atividades:
                        perguntas_por_tema[tema].append((pergunta, atividade))
                else:
                    perguntas_por_tema[tema].append((pergunta, None))
                if pergunta.tipo_resposta == 'multipla_escolha':
                    opcoes.append({'pergunta_id': pergunta.id, 'opcoes': OpcaoP.objects.filter(pergunta=pergunta.id).all()})

            return render(request, 'questionarios/responder_questionario.html', {
                'questionario': questionario,
                'perguntas_por_tema': perguntas_por_tema,
                'opcoes_dict': opcoes
            })
    else:
        return redirect('utilizadores:mensagem', 8000)


def verificarResponderQuestionario(request):
    anoCorrente = datetime.now().year
    diaabertoAtual = Diaaberto.objects.filter(ano=anoCorrente)
    user= get_user(request)
    if user.groups.filter(name="Participante").exists():
        if diaabertoAtual.count() == 0: #Se n existir dia Aberto para o ano Atual
            return redirect('utilizadores:mensagem',8002)
        else:
            questionarioId = diaabertoAtual[0].questionario
            if questionarioId == None: #Dia Aberto ainda n tem questionario
                return redirect('utilizadores:mensagem',8003)
            else:  #Dia aberto tem questionario
                questID = questionarioId.id
                pessoas_total = 0

                resposta = Resposta.objects.filter(questionario=questID).all()
                inscricoes = Inscricao.objects.filter(diaaberto=diaabertoAtual[0].id).all()
                
                for inscricao in inscricoes:
                    pessoas_total += inscricao.nalunos
                
                if resposta.count() < pessoas_total: #Ainda n respondeu ao questionario deste ano
                    return redirect('questionariosPublicados:responder_questionario',questID)
                else: # Ja excedeu o limite de respostas
                    return redirect('utilizadores:mensagem',8004) 
    else:
        return redirect('utilizadores:mensagem',8000) #nao é participante

def verificar_codigo(request, codigo):
    if Inscricao.objects.filter(codigo=codigo).exists():
        inscricao = Inscricao.objects.get(codigo=codigo)
        # Armazenar o código na sessão
        request.session['codigo_inscricao'] = codigo  # Armazenar o código
        request.session['inscricao_id'] = inscricao.id  # Armazenar o ID da inscrição se necessário
        return JsonResponse({'success': True, 'id': inscricao.id, 'message': 'Código verificado com sucesso!'})
    else:
        return JsonResponse({'success': False, 'message': 'Código inválido!'}, status=404)


"""from django.shortcuts import redirect, get_object_or_404, render
from .models import Questionario, Resposta
from configuracao.models import Diaaberto
from django.contrib import messages

def verificarQuestionario(request, dia_aberto_id):

    dia_aberto = get_object_or_404(Diaaberto, pk=dia_aberto_id)
    print(dia_aberto)
    questionarios = dia_aberto.questionarios.all()  # Assumindo que existe uma relação ManyToMany

    # Verifica se existem questionários ainda não respondidos para esse dia aberto
    for questionario in questionarios:
        if not Resposta.objects.filter(questionario=questionario, utilizador=request.user).exists():
            # Redireciona para responder o primeiro questionário não respondido
            return redirect('questionariosPublicados:responder_questionario', id=questionario.id)

    # Se todos os questionários foram respondidos, exibe uma mensagem de erro
    return redirect('utilizadores:mensagem',1008)  # Substitua 'nome_da_url_erro' pelo nome correto da URL de erro"""