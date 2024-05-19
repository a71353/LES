from django.forms import *

from atividades.forms import get_choices_time
from configuracao.models import Diaaberto 
from .models import Roteiro
from datetime import datetime


class RoteiroForm(ModelForm): 
    #duracaoesperada = ChoiceField(choices=[])

    class Meta:
        model = Roteiro
        exclude = ['id', 'coordenadorID', 'diaabertoid', 'duracaoesperada']
        widgets = {
            'nome': TextInput(attrs={'class': 'input'}),
            'nrmaximodeparticipantes': NumberInput(attrs={'class': 'input'}),
            #'duracaoesperada': Select(),
            'descricao': Textarea(attrs={'class':'textarea','rows': 5, 'cols': 40 }),
            'publicoalvo': Select(),
        }

    def __init__(self, *args, **kwargs):
        super(RoteiroForm, self).__init__(*args, **kwargs)
        #self.fields['duracaoesperada'].choices = get_choices_time()
        