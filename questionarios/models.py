# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models
from django.core import validators
from django.utils import timezone
import time
from time import mktime
from datetime import date, datetime,timedelta, time as datetime_time
from django.shortcuts import redirect
from django.utils.safestring import mark_safe
from django.urls.base import reverse
from django.utils.html import escape
from django.core.exceptions import NON_FIELD_ERRORS
from django.core.exceptions import ValidationError
import re
from django.utils.text import slugify


class EstadoQuestionario(models.Model):
    id = models.CharField(max_length=3, primary_key=True, editable=False)  # Faz o campo 'id' não editável no admin
    nome = models.CharField(max_length=255, unique=True)

    class Meta:
        db_table = 'estado_questionario'

    def __str__(self):
        return self.nome

    def save(self, *args, **kwargs):
        if not self.id:
            # Define o 'id' como as três primeiras letras do 'nome', em minúsculas
            # Utiliza 'slugify' para garantir que o 'id' seja válido para URLs (sem espaços, caracteres especiais, etc.)
            # Utiliza também [:3] para pegar apenas os primeiros três caracteres
            self.id = slugify(self.nome)[:3].lower()
        super(EstadoQuestionario, self).save(*args, **kwargs)

# Updated Questionario model with a ForeignKey to EstadoQuestionario
class Questionario(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)
    nome = models.CharField(max_length=255, db_column='Nome')
    autor = models.ForeignKey("utilizadores.Administrador", verbose_name='Autor', on_delete=models.CASCADE)
    estado = models.ForeignKey(EstadoQuestionario, on_delete=models.SET_NULL, null=True, db_column='estado_id')
    estado_anterior = models.ForeignKey(EstadoQuestionario, on_delete=models.SET_NULL, null=True, blank=True, related_name='questionarios_anteriores')
    data_publicada = models.DateField(verbose_name='Data de Início da Publicação', null=True, blank=True, db_column='data_publicada')
    data_fim_publicacao = models.DateField(verbose_name='Data de Fim da Publicação', null=True, blank=True, db_column='data_fim_publicada')

    def clean(self):
        super().clean()
        if self.data_publicada and self.data_publicada < timezone.now().date():
            raise ValidationError({'data_publicada': 'A Data de Início da Publicação não pode ser anterior ao dia de hoje.'})
        if self.data_fim_publicacao and self.data_fim_publicacao < self.data_publicada:
            raise ValidationError({'data_fim_publicacao': 'A Data de Fim da Publicação não pode ser anterior à Data de Início da Publicação.'})

    class Meta:
        db_table = 'questionarios'

    def __str__(self):
        return f"{self.id} - {self.nome}, Estado: {self.estado.nome}"
       
    def arquivar(self):
        if self.estado.id not in ['arq', 'pub']:  # Impede arquivamento se já está arquivado ou publicado
            estado_arquivado = EstadoQuestionario.objects.get(id='arq')
            self.estado_anterior = self.estado  # Armazena o estado atual como estado anterior
            self.estado = estado_arquivado
            self.save()


    def desarquivar(self):
        if self.estado_anterior and self.estado.id == 'arq' and self.estado_anterior.id != 'pub':  # Verifica se o estado anterior não é publicado
            self.estado = self.estado_anterior
            self.estado_anterior = None  # Limpa o estado anterior
            self.save()
       
    
    
       



class Pergunta(models.Model):
    questionario = models.ForeignKey(Questionario, on_delete=models.CASCADE, related_name='perguntas')
    texto = models.CharField(max_length=255, verbose_name="Texto da Pergunta")
    tema = models.ForeignKey("atividades.TemaQ", verbose_name='Tema', on_delete=models.CASCADE)
    

    TIPOS_RESPOSTA = (
        ('texto_livre', 'Texto Livre'),
        ('multipla_escolha', 'Escolha Múltipla'),
        ('inteiro', 'Inteiro'),

    )
    tipo_resposta = models.CharField(max_length=20, choices=TIPOS_RESPOSTA)
    class Meta:
        db_table = 'perguntas'
        verbose_name = 'Pergunta'
        verbose_name_plural = 'Perguntas'

    def __str__(self):
        return f"Pergunta: {self.texto}, Questionário ID: {self.questionario_id}"



class OpcaoP(models.Model):
    pergunta = models.ForeignKey(Pergunta, on_delete=models.CASCADE, related_name='opcoes')
    texto_opcao = models.CharField(max_length=255, verbose_name="Texto da Opção")

    class Meta:
        db_table = 'opcoes_pergunta'
        verbose_name = 'Opção de Pergunta'
        verbose_name_plural = 'Opções de Perguntas'

    def __str__(self):
        return f"Opção: {self.texto_opcao}, Pergunta ID: {self.pergunta_id}"
