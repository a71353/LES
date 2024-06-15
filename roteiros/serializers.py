from configuracao.models import Horario
from atividades.serializers import SessaoSerializer
from roteiros.models import Roteiro
from rest_framework import serializers

class RoteiroSerializer(serializers.ModelSerializer):
    sessao_set = SessaoSerializer(many=True, read_only=True)

    class Meta:
        model = Roteiro
        fields = '__all__'
