from django.utils import timezone
from django.core.exceptions import ValidationError
from django.db import models

class Relatorio(models.Model):
    id = models.AutoField(primary_key=True)
    tema = models.CharField(max_length=255)
    dia_aberto = models.ForeignKey('configuracao.Diaaberto', on_delete=models.CASCADE, verbose_name='Dia Aberto Associado')
    autor = models.ForeignKey("utilizadores.Administrador", verbose_name='Autor', on_delete=models.CASCADE)
    data_exportado = models.DateField(verbose_name='Data de Exportação', null=True, blank=True)
    export_type = models.CharField(max_length=100, verbose_name='Tipo de documento')

    class Meta:
        db_table = 'relatorios'


    def __str__(self):
        return f"{self.tema} ({self.dia_aberto.ano}) - {self.autor.nome}"

    def exportar(self):
        # Método para exportar o relatório
        self.data_exportado = timezone.now().date()
        self.save()

    @property
    def ano(self):
        # Retorna o ano do Dia Aberto associado
        return self.dia_aberto.ano