import django_tables2 as tables
from django.utils.html import format_html
from django.urls import reverse
from .models import Relatorio  # Certifique-se de que o caminho está correto

class RelatorioTable(tables.Table):
    acoes = tables.Column(verbose_name='Operações', empty_values=(), orderable=False)
    ano = tables.Column(accessor='dia_aberto.ano', verbose_name='Ano')  # Adicionando uma coluna customizada para o ano

    class Meta:
        model = Relatorio
        sequence = ('id', 'tema', 'ano', 'autor', 'data_exportado', 'export_type')  # Especifica os campos que você deseja incluir na tabela
        attrs = {"class": "table is-striped is-narrow is-hoverable is-fullwidth"}

    def before_render(self, request):
        self.columns.hide('id')
        self.columns.hide('autor')
        self.columns.hide('ano')


    def render_acoes(self, record):

        export_url = "#"
        # Certifique-se de usar o método lower() tanto para tema quanto para tipo, garantindo a comparação correta.
        tema = record.tema.lower()
        tipo = record.export_type.lower()  # Assumindo que `export_type` é um método ou atributo acessível.

        # Lógica condicional baseada no tema e tipo
        if tema == "transporte" and tipo == 'pdf':
            export_url = reverse('relatorios:relatorio_transporte', kwargs={'ano': record.dia_aberto.ano, 'rep': 'no'})
        elif tema == "transporte" and tipo == 'csv':
            export_url = reverse('relatorios:relatorio_transporte_csv', kwargs={'ano': record.dia_aberto.ano, 'rep': 'no'})
        elif tema == "atividade" and tipo == 'pdf':
            export_url = reverse('relatorios:relatorio_atividade', kwargs={'ano': record.dia_aberto.ano,'rep': 'no'})
        elif tema == "atividade" and tipo == 'csv':
            export_url = reverse('relatorios:relatorio_atividade_csv', kwargs={'ano': record.dia_aberto.ano, 'rep': 'no'})
        elif tema == "presencas" and tipo == 'pdf':
            export_url = reverse('relatorios:relatorio_presencas', kwargs={'ano': record.dia_aberto.ano, 'rep': 'no'})
        elif tema == "presencas" and tipo == 'csv':
            export_url = reverse('relatorios:relatorio_presencas_csv', kwargs={'ano': record.dia_aberto.ano, 'rep': 'no'})
        elif tema == "almoco" and tipo == 'pdf':
            export_url = reverse('relatorios:relatorio_almoco_pdf', kwargs={'ano': record.dia_aberto.ano,'rep': 'no'})
        elif tema == "almoco" and tipo == 'csv':
            export_url = reverse('relatorios:relatorio_almoco_csv', kwargs={'ano': record.dia_aberto.ano, 'rep': 'no'})

        delete_confirmation = "return confirm('Tem certeza que deseja eliminar este Relatório?');"
       

        # Monta o HTML para as ações
        return format_html(f"""
        <div>
            <a href="{export_url}">
                <span class="icon is-small">
                    <i class="mdi mdi-file-export mdi-24px"></i>
                </span>
            </a>
            &nbsp;
            <a href="#" onclick="{delete_confirmation}">
                <span class="icon is-small">
                    <i class="mdi mdi-delete mdi-24px" style="color: #ff0000"></i>
                </span>
            </a>
        </div>
        """)