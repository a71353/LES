import django_tables2 as tables
from questionarios.models import *
from django.utils.html import format_html
from django.db.models import Count
from questionarios.models import Questionario  # Ajuste o caminho de importação conforme necessário


import django_tables2 as django_tables
from .models import *
from django.utils.html import format_html
from django.urls import reverse
from django.contrib.auth import *



from django.urls import reverse
from django.utils.html import format_html

class QuestionarioTable(tables.Table):
    acoes = tables.Column(verbose_name='Operações', empty_values=(), orderable=False)

    class Meta:
        model = Questionario
        sequence = ('id', 'nome',)  # Especifique aqui os campos que deseja incluir na tabela
        attrs = {"class": "table is-striped is-narrow is-hoverable is-fullwidth"}
        exclude = ('estado_anterior',)

    def before_render(self, request):
        self.columns.hide('id')
        self.columns.hide('estado')

    def render_acoes(self, record):
        user_id = self.request.user.id
        if Resposta.objects.filter(questionario=record, utilizador__id=user_id).exists():
            return format_html(f"""
                <div>
                    <span style="color:green;">Respondido</span>
                </div>
            """)  # Se o usuário já respondeu, não renderize nada para ocultar visualmente
        else:
            return format_html(f"""
                <div>
                    <a id='responder' href="{reverse('questionariosPublicados:responder_questionario', kwargs={'id': record.pk})}">
                        <span class="icon is-small">
                            <i class="mdi mdi-circle-edit-outline mdi-24px"></i>
                        </span>
                    </a>
                    &nbsp;
                </div>
            """)
