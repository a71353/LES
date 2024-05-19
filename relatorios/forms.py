from django import forms
from configuracao.models import Diaaberto
from utilizadores.models import Administrador
from .models import Relatorio

class RelatorioForm(forms.ModelForm):
    tema = forms.CharField(max_length=255)

    data_exportado = forms.DateField(
        required=False,
        widget=forms.DateInput(attrs={'type': 'date'}),
        label='Data de Exportação'
    )
    export_type = forms.CharField(max_length=100)

    class Meta:
        model = Relatorio
        fields = ['tema', 'autor', 'dia_aberto', 'data_exportado', 'export_type']

    def clean(self):
        cleaned_data = super().clean()
        dia_aberto = cleaned_data.get("dia_aberto")
        tema = cleaned_data.get("tema")
        autor = cleaned_data.get("autor")
        export_type = cleaned_data.get("export_type")  # Certifique-se de que este campo está sendo capturado corretamente
        data_exportado = cleaned_data.get("data_exportado")

        # Inclui 'export_type' na verificação de duplicidade
        if Relatorio.objects.filter(dia_aberto=dia_aberto, tema=tema, autor=autor, export_type=export_type, data_exportado=data_exportado).exists():
            msg = f"Já existe um relatório com o tema '{tema}', tipo '{export_type}' para o Dia Aberto associado por este autor."
            self.add_error('tema', forms.ValidationError(msg))

        return cleaned_data
