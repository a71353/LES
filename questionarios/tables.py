import django_tables2 as tables
from questionarios.models import *
from django.utils.html import format_html
from django.db.models import Count
from .models import Questionario  # Ajuste o caminho de importação conforme necessário
from django.contrib.auth import get_user


class QuestionarioTable(tables.Table):
    acoes = tables.Column(verbose_name='Operações', empty_values=(), orderable=False)
    
    class Meta:
        model = Questionario
        sequence = ('id','nome', 'estado', 'autor')  # Especifique aqui os campos que deseja incluir na tabela
        attrs = {"class": "table is-striped is-narrow is-hoverable is-fullwidth"}
    

    def before_render(self, request):
        self.columns.hide('id')
        self.columns.hide('autor')
        self.columns.hide('estado_anterior')

       # self.columns.hide('estado')
        
    
    def render_estado(self, record):
        estado_nome = record.estado.nome  # Acesso direto ao nome do estado através do objeto relacionado
        if estado_nome == 'disponivel':
            fancy_box = """
            <span class="tag text is-warning" style="width: 7rem;font-size: small; background-color: blue; color: white;">Disponível</span>
            """
        elif estado_nome == 'indisponivel':
            fancy_box = """
            <span class="tag text is-info" style="width: 7rem;font-size: small; background-color: red;">Indisponivel</span>
            """
        elif estado_nome == 'pendente':
            fancy_box = """
            <span class="tag text is-success" style="width: 7rem;font-size: small;">Pendente</span>
            """
        elif estado_nome == 'arquivado':
            fancy_box = """
            <span class="tag text is-info" style="width: 7rem;font-size: small; background-color: #ffd700">Arquivado</span>
            """
        elif estado_nome == 'publicado':
            fancy_box = """
            <span class="tag text is-info" style="width: 7rem;font-size: small; background-color: purple">Publicado</span>
            """
        else:
            # Caso existam outros estados futuramente, eles serão considerados aqui
            fancy_box = f"""
            <span class="tag" style="width: 7rem;font-size: small;">{estado_nome}</span>
            """
        return format_html(fancy_box)


    def render_acoes(self, record):
        user = get_user(self.request)
        if user.groups.filter(name="Administrador").exists():
            validar_button = ""
            estado_nome = record.estado.nome  # Acesso direto ao nome do estado através do objeto relacionado
            if estado_nome == 'pendente' or estado_nome == 'indisponivel':
                return format_html(f"""
                <div>
                    <a id='edit' href="{reverse('questionarios:editar_questionarios', kwargs={'id': record.pk})}">
                        <span class="icon is-small">
                            <i class="mdi mdi-circle-edit-outline mdi-24px"></i>
                        </span>
                    </a>
                    &nbsp;          
                    <a onclick="alert.render('Tem a certeza que pretende eliminar este Questionário?','{reverse('questionarios:deletar_questionario', kwargs={'id': record.pk})}')">
                        <span class="icon is-small">
                            <i class="mdi mdi-trash-can-outline mdi-24px" style="color: #ff0000"></i>
                        </span>
                    </a> 
                    &nbsp;
                    <a id='consultar' href="{reverse('questionarios:consultarQuestionario', kwargs={'id': record.pk})}">
                        <span class="icon is-small">
                            <i class="bi bi-eye-fill" style="color: black; font-size: 20px;"></i>
                        </span>
                    </a>
                    &nbsp;
                    <a id='consultar' href="{reverse('questionarios:exportarQuestionarioDraft', kwargs={'id': record.pk})}">
                        <span class="icon is-small">
                            <i class="fa-solid fa-file-pdf" style="color: #48C774; font-size: 20px;"></i>
                        </span>
                    </a>
                    &nbsp;
                    <a onclick="alert.render('Tem a certeza que pretende Arquivar este Questionário?','{reverse('questionarios:arquivarQuestionario', kwargs={'id': record.pk})}')">
                        <span class="icon is-small">
                            <i class="fa-solid fa-box" style="color: #ffd700"></i>
                        </span>
                    </a>
                    &nbsp;
                </div> 
            """)
            if estado_nome == 'arquivado':
                return format_html(f"""
                <div>
                    <a id='edit' href="{reverse('questionarios:editar_questionarios', kwargs={'id': record.pk})}">
                        <span class="icon is-small">
                            <i class="mdi mdi-circle-edit-outline mdi-24px"></i>
                        </span>
                    </a>
                    &nbsp;          
                    <a onclick="alert.render('Tem a certeza que pretende eliminar este Questionário?','{reverse('questionarios:deletar_questionario', kwargs={'id': record.pk})}')">
                        <span class="icon is-small">
                            <i class="mdi mdi-trash-can-outline mdi-24px" style="color: #ff0000"></i>
                        </span>
                    </a> 
                    &nbsp;
                    <a id='consultar' href="{reverse('questionarios:consultarQuestionario', kwargs={'id': record.pk})}">
                        <span class="icon is-small">
                            <i class="bi bi-eye-fill" style="color: black; font-size: 20px;"></i>
                        </span>
                    </a>
                    &nbsp;
                    <a id='consultar' href="{reverse('questionarios:exportarQuestionario', kwargs={'id': record.pk})}">
                        <span class="icon is-small">
                            <i class="fa-solid fa-file-pdf" style="color: black; font-size: 20px;"></i>
                        </span>
                    </a>
                    &nbsp;
                    <a onclick="alert.render('Tem a certeza que pretende Desarquivar este Questionário?','{reverse('questionarios:desarquivarQuestionario', kwargs={'id': record.pk})}')">
                        <span class="icon is-small">
                            <i class="fa-solid fa-box-open" style="color: black"></i>
                        </span>
                    </a>
                    &nbsp;
                </div> 
            """)
            if estado_nome == 'publicado':
                return format_html(f"""
                <div>
                    <a id='consultar' href="{reverse('questionarios:consultarQuestionario', kwargs={'id': record.pk})}">
                        <span class="icon is-small">
                            <i class="bi bi-eye-fill" style="color: black; font-size: 20px;"></i>
                        </span>
                    </a>
                    &nbsp;
                    <a id='consultar' href="{reverse('questionarios:exportarQuestionario', kwargs={'id': record.pk})}">
                        <span class="icon is-small">
                            <i class="fa-solid fa-file-pdf" style="color: black; font-size: 20px;"></i>
                        </span>
                    </a>
                    &nbsp;
                </div> 
            """)
            else:
                return format_html(f"""
                <div>        
                    <a onclick="alert.render('Tem a certeza que pretende eliminar este Questionário?','{reverse('questionarios:deletar_questionario', kwargs={'id': record.pk})}')">
                        <span class="icon is-small">
                            <i class="mdi mdi-trash-can-outline mdi-24px" style="color: #ff0000"></i>
                        </span>
                    </a> 
                    &nbsp;
                    <a id='consultar' href="{reverse('questionarios:consultarQuestionario', kwargs={'id': record.pk})}">
                        <span class="icon is-small">
                            <i class="bi bi-eye-fill" style="color: black; font-size: 20px;"></i>
                        </span>
                    </a>
                    &nbsp;
                    <a id='consultar' href="{reverse('questionarios:exportarQuestionario', kwargs={'id': record.pk})}">
                        <span class="icon is-small">
                            <i class="fa-solid fa-file-pdf" style="color: black; font-size: 20px;"></i>
                        </span>
                    </a>
                    &nbsp;
                    <a onclick="alert.render('Tem a certeza que pretende Arquivar este Questionário?','{reverse('questionarios:arquivarQuestionario', kwargs={'id': record.pk})}')">
                        <span class="icon is-small">
                            <i class="fa-solid fa-box" style="color: #ffd700"></i>
                        </span>
                    </a>
                    &nbsp;
                </div> 
            """)
        else:
            return ""
    


class PerguntasTable(tables.Table):
    acoes = tables.Column(verbose_name='Ações', empty_values=(), orderable=False)
    
    class Meta:
        model = Pergunta
        sequence = ('id','texto', 'tema', 'tipo_resposta')  # Especifique aqui os campos que deseja incluir na tabela
        attrs = {"class": "table is-striped is-narrow is-hoverable is-fullwidth"}
    

    def before_render(self, request):
        self.columns.hide('id')

       # self.columns.hide('estado')
    

    def render_acoes(self, record):
        return format_html(f"""
            <div>
                <a id='edit' href="{reverse('questionarios:editar_perguntas', kwargs={'id': record.pk})}">
                    <span class="icon is-small">
                        <i class="mdi mdi-circle-edit-outline mdi-24px"></i>
                    </span>
                </a>
                &nbsp;          
                <a onclick="alert.render('Tem a certeza que pretende eliminar este Questionário?','{reverse('questionarios:eliminarPergunta', kwargs={'id': record.pk})}')">
                    <span class="icon is-small">
                        <i class="mdi mdi-trash-can-outline mdi-24px" style="color: #ff0000"></i>
                    </span>
                </a> 
            </div> 
        """)
    
class EstadosTable(tables.Table):
    nome = tables.Column('Nome')
    acoes = tables.Column('Operações', empty_values=(), orderable=False, exclude_from_export=True)

    class Meta:
        model = EstadoQuestionario
        fields = ('id', 'nome')  # Especifique os campos que você quer mostrar na tabela
        attrs = {"class": "table is-striped is-hoverable"}  # Adicione suas classes CSS aqui

    def render_nome(self, value, record):
        return format_html(f"{record.nome}")

    def render_acoes(self, record):
        estados_proibidos = ['arquivado', 'disponivel', 'indisponivel', 'pendente', 'publicado']
        if record.nome in estados_proibidos:
            return format_html("<div>Não é possível alterar ou eliminar estes estados</div>")
        else:
            return format_html(f"""
                <div>
                    <a id='edit' href="{reverse('configuracao:editarEstado', kwargs={'id': record.pk})}">
                        <span class="icon is-small">
                            <i class="mdi mdi-circle-edit-outline mdi-24px"></i>
                        </span>
                    </a>             
                    <a onclick="alert.render('Tem a certeza que pretende eliminar este Estado?','{reverse('configuracao:eliminarEstado', kwargs={'id': record.pk})}')">
                        <span class="icon is-small">
                            <i class="mdi mdi-trash-can-outline mdi-24px" style="color: #ff0000"></i>
                        </span>
                    </a> 
                </div>
            """)

    def before_render(self, request):
        self.columns.hide('id')  # Se você preferir ocultar a coluna ID na visualização


      

      