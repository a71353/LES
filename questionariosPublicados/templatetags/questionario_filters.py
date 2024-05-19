from django import template

register = template.Library()

@register.filter
def get_by_key(value, arg):
    return value.get(arg, '')  # Retorna uma string vazia se a chave não existir
