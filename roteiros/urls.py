from django.urls import path
from . import views

app_name = 'roteiros'

urlpatterns = [
    path('criarRoteiro', views.roteiros ,name="criarRoteiro"),
    #path('meusRoteiros',views.RoteiroCoordenador.as_view(),name="meusRoteiros"),
    path('proporRoteiro',views.proporRoteiro,name='proporRoteiro'),
    path('sessao/<int:id>',views.inserirsessaoRoteiro,name='sessaoRoteiro'),
    path('verresumo/<int:id>',views.verresumo,name='verResumo'),
    path('confirmar/<int:id>',views.confirmarResumo,name='confirmarResumo'),
    path('eliminarsessao/<int:id>',views.eliminarSessaoRoteiro,name='eliminarSessao'),
    path('eliminarroteiro/<int:id>',views.eliminarRoteiro,name='eliminarRoteiro'),
    #path('duplicarRoteiros/<int:id>', views.duplicarRoteiro,name ='duplicarRoteiro' ),
    path('alterarRoteiros/<int:id>', views.alterarRoteiro,name ='alterarRoteiro' ),
    path('escolherDiaAberto/<int:id>', views.escolherDiaAberto, name='escolherDiaAberto'),
    path('roteiro/<int:id>/duplicar/<int:novo_diaaberto_id>/', views.duplicarRoteiro, name='duplicarRoteiro'),
    path('verRelatorio/<int:id>', views.verRelatorio, name='verRelatorio'),
    path('verTodosRelatorios', views.verTodosRelatorios, name='verTodosRelatorios'),
    path('escolherDiaAberto2/<int:id>', views.escolherDiaAberto2, name='escolherDiaAberto2'),
    path('alterarRoteiros2/<int:id>', views.alterarRoteiro2,name ='alterarRoteiro2' ),
    path('eliminarroteiro2/<int:id>',views.eliminarRoteiro2,name='eliminarRoteiro2')
 
    
]

