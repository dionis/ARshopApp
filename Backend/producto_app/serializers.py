from .models import Categoria, Producto, Entidad
from rest_framework import serializers


class CategoriaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Categoria
        fields = '__all__'


class EntidadSerializer(serializers.ModelSerializer):
    class Meta:
        model = Entidad
        fields = '__all__'


class ProductoSerializer(serializers.ModelSerializer):
    categoria = CategoriaSerializer()
    entidad = EntidadSerializer()

    class Meta:
        model = Producto
        fields = '__all__'


class ProductoSaveSerializer(serializers.ModelSerializer):
    class Meta:
        model = Producto
        fields = '__all__'
