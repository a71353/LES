import django_tables2 as tables
from roteiros.models import *
from django.utils.html import format_html


class CoordRoteiroTable(tables.Table):
    coordenadorID = tables.Column('Coordenador')
    datasubmissao = tables.Column('Data de Submissão')
    class Meta:
        model = Roteiro
        sequence = ('nome','coordenadorID','datasubmissao')
    def before_render(self, request):
        self.columns.hide('id')
        self.columns.hide('descricao')
        self.columns.hide('publicoalvo')
        self.columns.hide('duracaoesperada')
        self.columns.hide('participantesmaximo')
        self.columns.hide('diaabertoid')

    def render_coordenadorID(self,record):
        return str(record.coordenadorID.full_name)

