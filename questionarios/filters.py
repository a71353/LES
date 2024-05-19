import django_filters
from django.db.models import Exists, OuterRef
import datetime
from questionarios.models import *
from atividades.models import Tema
from django.forms.widgets import TextInput
import django_filters
from .models import Questionario

class QuestionarioFilter(django_filters.FilterSet):
    nome = django_filters.CharFilter(field_name="nome", lookup_expr='icontains', label="Nome")

    # Aqui, vamos obter os estados diretamente do banco de dados
    estado = django_filters.ModelChoiceFilter(queryset=EstadoQuestionario.objects.all(), 
                                              field_name="estado__nome", 
                                              label="Estado do Questionário",
                                              empty_label="Selecione um Estado")

    class Meta:
        model = Questionario
        fields = ['nome', 'estado']


class EstadosFilter(django_filters.FilterSet):
    nome = django_filters.CharFilter(field_name="nome", lookup_expr='icontains', label="Nome do Estado")

    class Meta:
        model = EstadoQuestionario
        fields = ['nome']