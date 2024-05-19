from django.contrib import admin
from django.urls import path
from . import views

app_name = 'relatorios'

urlpatterns = [

    path('', views.ListaRelatorios.as_view(), name='lista_relatorios'),
    path('relatorio_transporte/<int:ano>/<str:rep>/', views.relatorio_transporte, name='relatorio_transporte'),
    path('relatorio_transporte_csv/<int:ano>/<str:rep>/', views.relatorio_transporte_csv, name='relatorio_transporte_csv'),
    path('relatorio_transporte_dia/<int:ano>/<str:rep>/<str:day>/', views.relatorio_transporte_dia, name='relatorio_transporte_dia'),
    path('relatorio_transporte_csv_dia/<int:ano>/<str:rep>/<str:day>/', views.relatorio_transporte_csv_dia, name='relatorio_transporte_csv_dia'),
    path('relatorio_atividade/<int:ano>/<str:rep>/', views.relatorio_atividade, name='relatorio_atividade'),
    path('relatorio_atividade_csv/<int:ano>/<str:rep>/', views.relatorio_atividade_csv, name='relatorio_atividade_csv'),
    path('relatorio_atividade_dia/<int:ano>/<str:rep>/<str:day>/', views.relatorio_atividade_dia, name='relatorio_atividade_dia'),
    path('relatorio_atividade_csv_dia/<int:ano>/<str:rep>/<str:day>/', views.relatorio_atividade_csv_dia, name='relatorio_atividade_csv_dia'),
    path('relatorio/', views.relatorio_view, name='p_relatorio'),
    path('relatorios/abrir/<str:filename>/', views.abrir_relatorio, name='abrir_relatorio'),
    path('relatorios/deletar/<str:filename>/', views.deletar_relatorio, name='deletar_relatorio'),


    path('relatorio_almoco_pdf/<int:ano>/<str:rep>/', views.relatorio_almoco_pdf, name='relatorio_almoco_pdf'),
    path('relatorio_almoco_csv/<int:ano>/<str:rep>/', views.relatorio_almoco_csv, name='relatorio_almoco_csv'),
    #path('relatorio_gustavo/<int:ano>/<str:rep>/<str:day>/', views.gustavo, name='relatorio_gustavo'),
    path('relatorio_almoco_dia_pdf/<int:ano>/<str:rep>/<str:day>/', views.relatorio_almoco_dia_pdf, name='relatorio_almoco_dia_pdf'),
    
    path('relatorio_almoco_dia_csv/<int:ano>/<str:rep>/<str:day>', views.relatorio_almoco_dia_csv, name='relatorio_almoco_dia_csv'),

    path('inscricoes_por_dia/<str:tema>/<int:ano>/', views.inscricoes_por_dia, name='inscricoes_por_dia'),
    path('get_anos_disponiveis_almocos/', views.get_anos_disponiveis_almocos, name='get_anos_disponiveis_almocos'),


]