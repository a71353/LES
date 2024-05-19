from django.contrib import admin
from django.urls import path
from . import views

app_name = 'questionariosPublicados'

urlpatterns = [

    path('', views.ListaQuestionarios.as_view(), name='lista_questionarios'),
    path('responder/<int:id>/', views.responderQuestionario, name='responder_questionario'),
    path('verificarquestionario', views.verificarResponderQuestionario, name='verificar-questionario'),
    #path('verificarQuestionario/<int:dia_aberto_id>/', views.verificarQuestionario, name='verificarQuestionario'),
    path('verificar-codigo/<str:codigo>/', views.verificar_codigo, name='verificar_codigo'),

]