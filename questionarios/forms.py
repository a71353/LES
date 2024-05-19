from django import forms
from .models import Questionario
from .models import Pergunta
from .models import OpcaoP
from django.forms import DateInput, TextInput, ValidationError, formset_factory
from django import forms
from atividades.models import TemaQ
from configuracao.models import Diaaberto
from .models import EstadoQuestionario


class QuestionarioForm(forms.ModelForm):
    dias_abertos = forms.ModelMultipleChoiceField(
        queryset=Diaaberto.objects.all().order_by('ano'),  # Ajuste a ordenação conforme necessário
        widget=forms.CheckboxSelectMultiple,
        required=False,
        label="Selecione os anos dos Dias Abertos",
    )

    nome = forms.CharField()
    data_publicada = forms.DateField(
        required=True,
        widget=forms.DateInput(attrs={'type': 'date', 'class': 'input'}),
        label="Data do início de Publicação"
    )
    data_fim_publicacao = forms.DateField(
        required=True,
        widget=forms.DateInput(attrs={'type': 'date', 'class': 'input'}),
        label="Data do fim de Publicação"
    )



    class Meta:
        model = Questionario
        fields = ['nome', 'dias_abertos', 'data_publicada', 'data_fim_publicacao']  # Inclui o novo campo data_publicada

    def __init__(self, *args, **kwargs):
        is_duplicating = kwargs.pop('is_duplicating', False)
        super(QuestionarioForm, self).__init__(*args, **kwargs)

        if is_duplicating:
            # Definindo os campos nome e data_publicada como ocultos
            self.fields['nome'].widget = forms.HiddenInput()
            self.fields['data_publicada'].widget = forms.HiddenInput()
            self.fields['data_fim_publicacao'].widget = forms.HiddenInput()

        if self.instance.pk:  # Verifica se a instância do formulário tem um ID
            self.fields['dias_abertos'].initial = self.instance.dias_abertos.all()
            self.fields['data_publicada'].initial = self.instance.data_publicada
            self.fields['data_fim_publicacao'].initial = self.instance.data_fim_publicacao

            
      
    def clean(self):
        cleaned_data = super().clean()
        dias_abertos_selecionados = cleaned_data.get("dias_abertos")
        
        for dia_aberto in dias_abertos_selecionados:
            questionarios_existentes = Questionario.objects.filter(dias_abertos__ano=dia_aberto.ano).exclude(pk=self.instance.pk)
            
            if questionarios_existentes.exists():
                nomes_questionarios = ", ".join([q.nome for q in questionarios_existentes])
                msg = f"Já existe um questionário associado ao ano {dia_aberto.ano} do Dia Aberto selecionado: {nomes_questionarios}."
                self.add_error('dias_abertos', ValidationError(msg))
        
        return cleaned_data



    def clean(self):
        cleaned_data = super().clean()
        dias_abertos_selecionados = cleaned_data.get("dias_abertos")
        
        for dia_aberto in dias_abertos_selecionados:
            questionarios_existentes = Questionario.objects.filter(dias_abertos__ano=dia_aberto.ano).exclude(pk=self.instance.pk)
            
            if questionarios_existentes.exists():
                nomes_questionarios = ", ".join([q.nome for q in questionarios_existentes])
                msg = f"Já existe um questionário associado ao ano {dia_aberto.ano} do Dia Aberto selecionado: {nomes_questionarios}."
                self.add_error('dias_abertos', ValidationError(msg))
        
        return cleaned_data
    
    
    class Meta:
        model = Questionario
        fields = ['nome', 'dias_abertos', 'data_publicada', 'data_fim_publicacao']  # Inclui o novo campo data_publicada

class PerguntaForm(forms.ModelForm):
    tema = forms.ModelChoiceField(queryset=TemaQ.objects.all(), required=True, label='Tema', widget=forms.Select(attrs={'class': 'form-control'}))

    class Meta:
        model = Pergunta
        fields = ['texto', 'tipo_resposta', 'tema']  # Adiciona 'tema' aos campos
        labels = {
            'texto': 'Texto da Pergunta',
            'tipo_resposta': 'Tipo de Resposta',
            'tema': 'Tema',  # Adiciona um rótulo para o campo de tema
        }
        help_texts = {
            'texto': 'Insira o texto completo da pergunta.',
            'tipo_resposta': 'Selecione o tipo de resposta para esta pergunta.',
            'tema': 'Selecione o tema associado a esta pergunta.',  # Adiciona um texto de ajuda
        }
        widgets = {
            'texto': forms.TextInput(attrs={'class': 'form-control'}),
            'tipo_resposta': forms.Select(attrs={'class': 'form-control'}),
            # O widget de 'tema' é definido no campo ModelChoiceField
        }


class OpcaoForm(forms.ModelForm):
    class Meta:
        model = OpcaoP
        fields = ['texto_opcao']  # Adapte conforme a estrutura do seu modelo Opcao
        labels = {
            'texto_opcao': 'Texto da Opção',
        }
        widgets = {
            'texto_opcao': forms.TextInput(attrs={'class': 'form-control'}),
        }

    


OpcaoFormSet = formset_factory(OpcaoForm, extra=1)


class EstadoQuestionarioForm(forms.ModelForm):
    class Meta:
        model = EstadoQuestionario
        fields = ['nome']
        widgets = {
            'nome': TextInput(attrs={'class':'input'}),
        }