

# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models
from django.utils.safestring import mark_safe
from django.urls import reverse

from datetime import date


class Roteiro(models.Model):
    # Field name made lowercase.
    id = models.AutoField(db_column='ID', primary_key=True)
    # Field name made lowercase.
    nome = models.CharField(db_column='Nome', max_length=255)
    # Field name made lowercase.
    descricao = models.TextField(db_column='Descricao')
    
    coordenadorID = models.ForeignKey(
        'utilizadores.Coordenador', models.CASCADE, db_column='coordenadorID')  
    diaabertoid = models.ForeignKey(
        'configuracao.Diaaberto', models.CASCADE, db_column='diaabertoID')
    participantesmaximo = models.IntegerField(db_column='nrmaximodeparticipantes')
    duracaoesperada = models.IntegerField(db_column='duracaoEsperada')
    publicosalvo = (("Ciencias e Tecnologia", "Ciências e Tecnologia"),
                    ("Linguas e Humanidades", "Linguas e Humanidades"), ("Economia", "Economia"))
    publicoalvo = models.CharField(
        db_column='Publicoalvo', max_length=255, choices=publicosalvo, default='')
    


    def eq(self, other):
        return self.nome == other.nome and \
        self.descricao == other.descricao and \
        self.coordenadorID == other.coordenadorID and \
        self.diaabertoid == other.diaabertoid and \
        self.participantesmaximo == other.participantesmaximo and \
        self.duracaoesperada == other.duracaoesperada and \
        self.publicoalvo == other.publicoalvo



    def ne(self, other):
        return False if self.eq(other) else True
    
 
    
    class Meta:
        db_table = 'Roteiro'




    
