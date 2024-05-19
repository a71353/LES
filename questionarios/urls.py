from django.contrib import admin
from django.urls import path
from . import views

app_name = 'questionarios'

urlpatterns = [

    path('', views.ListaQuestionarios.as_view(), name='lista_questionarios'),
    path('criar', views.criarQuestionario, name='criar_questionario'),
    path('perguntas/<int:id>', views.inserirPerguntas, name='inserirPerguntas'),
    path('eliminarPergunta/<int:id>',views.eliminarPergunta,name='eliminarPergunta'),
    path('editar/<int:id>/', views.editarQuestionario, name='editar_questionarios'),
    path('deletar/<int:id>/', views.deletarQuestionario, name='deletar_questionario'),
    path('editar/perguntas/<int:id>/', views.editar_pergunta, name='editar_perguntas'),

    ##############Gustavo#############
    path('consultar/<int:id>/', views.consultarQuestionario, name='consultarQuestionario'),
    path('validar/<int:id>', views.validarQuestionario, name='validarQuestionario'),
    path('rejeitar/<int:id>', views.rejeitarQuestionario, name='rejeitarQuestionario'),
    path('publicar/<int:id>', views.publicarQuestionario, name='publicarQuestionario'),
    path('despublicar/<int:id>', views.despublicarQuestionario, name='despublicarQuestionario'),
    path('arquivar/<int:id>', views.arquivarQuestionario, name='arquivarQuestionario'),
    path('desarquivar/<int:id>', views.desarquivarQuestionario, name='desarquivarQuestionario'),
    path('exportar/<int:id>', views.exportar_questionarios_pdf, name='exportarQuestionario'),
    path('exportarDraft/<int:id>', views.exportar_questionarios_draft_pdf, name='exportarQuestionarioDraft'),
    path('enviar-motivo-rejeicao/<int:id>/', views.enviar_motivo_rejeicao, name='enviarMotivoRejeicao'),
    path('reverter-indisponivel/<int:id>/', views.reverterIndisponivel, name='reverterIndisponivel'),


]
