from django.contrib import admin
from django.urls import path
from . import views

app_name = 'estatisticas'

urlpatterns = [

    path('estatisticas_almocos', views.estatisticas_almocos, name='estatisticas_almocos'),
    path('estatisticas_almocos_csv/', views.estatisticas_almocos_csv, name='estatisticas_almocos_csv'),
    path('estatisticas_almocos_excel/', views.estatisticas_almocos_excel, name='estatisticas_almocos_excel'),
    path('estatistica_transporte', views.estatistica_transporte, name='estatistica_transporte'),

]
