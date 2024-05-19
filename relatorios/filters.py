# Este é um exemplo de como criar um Form de Filtros se você ainda não tem um
from django import forms
from django.utils import timezone
from .models import Relatorio
import django_filters

class RelatorioFilter(django_filters.FilterSet):
    nome = django_filters.CharFilter(field_name='nome', lookup_expr='icontains')
    tipo = django_filters.CharFilter(field_name='tipo', lookup_expr='icontains')
    data = django_filters.DateFilter(field_name='data_criacao', lookup_expr='gte')

    class Meta:
        model = Relatorio
        fields = ['nome', 'tipo', 'data']