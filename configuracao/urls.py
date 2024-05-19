from django.contrib import admin
from django.urls import path
from . import views

app_name = 'configuracao'

urlpatterns = [

    #-diaAberto
    path('diasabertos', views.viewDays.as_view(), name='diasAbertos'),
    path('editardia/<int:id>', views.newDay, name='editarDia'),
    path('inserirdiaaberto', views.newDay,name='novoDia' ),
    path('deldia/<int:id>', views.delDay, name='eliminarDia'),
    #path('daysjson', views.view_days_as_json, name='daysjson'),

    #-almoco
    path('menus',views.verMenus.as_view(), name='verMenus'),
    path('delmenu/<int:id>', views.delMenu, name='eliminarMenu'),
    path('editarmenu/<int:id>',views.newMenu, name='editarMenu'),
    path('novomenu', views.newMenu, name='novoMenu'),
    #-Transporte
    path('transportes', views.verTransportes.as_view(), name='verTransportes'),
    path('criartransporte', views.criarTransporte, name='criarTransporte'),
    path('editartransporte/<int:id>', views.criarTransporte, name='editarTransporte'),
    path('atribuirtransporte/<int:id>', views.atribuirTransporte, name='atribuirTransporte'),
    path('eliminaratribuicao/<int:id>', views.eliminarAtribuicao, name='eliminarAtribuicao'),
    path('eliminartransporte/<int:id>', views.eliminarTransporte, name='eliminarTransporte'),
    #-Utility
    path('imagens/edificio/<int:id>', views.verEdificioImagem, name='verEdificioImagem'),
    path('edificios', views.verEdificios.as_view(), name='verEdificios'),
    path('adicionaredificio', views.configurarEdificio, name='adicionarEdificio'),
    path('editaredificio/<int:id>', views.configurarEdificio, name='editarEdificio'),
    path('eliminaredificio/<int:id>', views.eliminarEdificio,name='eliminarEdificio'),

    path('uos', views.verUOs.as_view(), name='verUOs'),
    path('adicionaruo', views.configurarUO, name='adicionarUO'),
    path('editaruo/<int:id>', views.configurarUO, name='editarUO'),
    path('eliminaruo/<int:id>', views.eliminarUO,name='eliminarUO'),

    path('temas', views.verTemas.as_view(), name='verTemas'),
    path('adicionarTema', views.configurarTema, name='adicionarTema'),
    path('editarTema/<int:id>', views.configurarTema, name='editarTema'),
    path('eliminarTema/<int:id>', views.eliminarTema,name='eliminarTema'),


    path('temasQ', views.verTemasQ.as_view(), name='verTemasQ'),
    path('adicionarTemaQ', views.configurarTemaQ, name='adicionarTemaQ'),
    path('editarTemaQ/<int:id>', views.configurarTemaQ, name='editarTemaQ'),
    path('eliminarTemaQ/<int:id>', views.eliminarTemaQ,name='eliminarTemaQ'),

    path('departamentos', views.verDepartamentos.as_view(), name='verDepartamentos'),
    path('adicionarDepartamento', views.configurarDepartamento, name='adicionarDepartamento'),
    path('editarDepartamento/<int:id>', views.configurarDepartamento, name='editarDepartamento'),
    path('eliminarDepartamento/<int:id>', views.eliminarDepartamento,name='eliminarDepartamento'),

    path('cursos', views.verCursos.as_view(), name='verCursos'),
    path('adicionarCurso', views.configurarCurso, name='adicionarCurso'),
    path('editarCurso/<int:id>', views.configurarCurso, name='editarCurso'),
    path('eliminarCurso/<int:id>', views.eliminarCurso,name='eliminarCurso'),

    path('Estados', views.verEstados.as_view(), name='verEstados'),
    #path('editarTemaQ/<int:id>', views.configurarEstado, name='editarTemaQ'),
    path('adicionarEstado', views.adicionarEstado, name='adicionarEstado'),
    path('editarEstado/<str:id>', views.configurarEstado, name='editarEstado'),
    path('eliminarEstado/<str:id>/', views.eliminarEstado, name='eliminarEstado'),


    #ajax ----------
    path('ajax/getDias', views.getDias, name='getDias'),
    path('ajax/addHorarioRow', views.newHorarioRow, name='ajaxAddHorarioRow'),
    path('ajax/addPratoRow', views.newPratoRow, name='ajaxAddPratoRow'),
    path('ajax/addEspacoRow', views.newEspacoRow, name='ajaxAddEspacoRow'),
    path('ajax/addUORow', views.newUORow, name='ajaxAddUORow'),
    path('ajax/addDepartamentoRow', views.newDepartamentoRow, name='ajaxAddDepartamentoRow'),
    path('ajax/addCursoRow', views.newCursoRow, name='ajaxAddCursoRow'),

]
