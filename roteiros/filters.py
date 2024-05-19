from atividades.models import Sessao,Roteiro
import django_filters
from django.db.models import Exists, OuterRef
from datetime import datetime
from django.forms.widgets import CheckboxSelectMultiple


def filter_sessoes(queryset, name, value):
    dia_vagas_de_ate = value.split('_')
    dia = dia_vagas_de_ate[0] if dia_vagas_de_ate[0] else datetime.date.today().strftime("%Y-%m-%d")
    vagas = dia_vagas_de_ate[1] if dia_vagas_de_ate[1] else 0
    de = dia_vagas_de_ate[2] if dia_vagas_de_ate[2] else '00:00'
    ate = dia_vagas_de_ate[3] if dia_vagas_de_ate[3] else '23:55'
    print(f"De: {de} | Até: {ate}")
    return queryset.filter(
        Exists(Sessao.objects.filter(
            roteiroid=OuterRef('id'),
            dia=dia,
            vagas__gte=vagas,
            horarioid__inicio__gte=de,
            horarioid__fim__lte=ate,
        ))
    )


class CoordRoteiroFilter(django_filters.FilterSet):
    nome = django_filters.CharFilter(
        field_name="nome", lookup_expr='icontains')
    departamento_id = django_filters.NumberFilter(
        field_name="coordenadorID__departamento__id")
    campus_id = django_filters.NumberFilter(
        field_name="espacoid__edificio__campus__id")
    sessoes = django_filters.CharFilter(method=filter_sessoes)
    #estado = django_filters.MultipleChoiceFilter(field_name='estado', choices=[('Aceite','Aceite'),('Pendente','Pendente'),('Recusada','Recusada')], widget=CheckboxSelectMultiple())

    class Meta:
        model = Roteiro
        fields = '__all__'
