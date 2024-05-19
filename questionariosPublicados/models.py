from django.db import models
from questionarios.models import *
from utilizadores.models import *
from atividades.models import *

# Create your models here.

class Resposta(models.Model):
    id = models.AutoField(db_column='id', primary_key=True)
    questionario = models.ForeignKey(Questionario, on_delete=models.CASCADE, related_name='respostas')
    data = models.DateTimeField(blank=True, null=True)
    codigo = models.CharField(max_length=20, unique=False, blank=True, null=True)

    class Meta:
        db_table = 'respostas'


class Resposta_Individual(models.Model):
    id = models.AutoField(db_column='id', primary_key=True)
    resposta = models.ForeignKey(Resposta, on_delete=models.CASCADE, related_name='resposta')
    pergunta = models.ForeignKey(Pergunta,default=3, on_delete=models.CASCADE, related_name='perguntaId')
    tipo_pergunta = models.CharField(max_length=20)
    resposta_texto = models.TextField()
    atividade = models.ForeignKey(Atividade, on_delete=models.SET_NULL, null=True, blank=True)

    class Meta:
        db_table = 'respostas_individuais'



'''class Respostas_Usuario(models.Model):
    id = models.AutoField(db_column='id', primary_key=True)
    utilizador = models.ForeignKey(Utilizador, on_delete=models.CASCADE, related_name='utilizador')
    questionario = models.ForeignKey(Questionario, on_delete=models.CASCADE, related_name='questionario')

    class Meta:
        db_table = 'respostas_usuario'''