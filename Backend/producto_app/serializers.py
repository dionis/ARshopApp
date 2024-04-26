from .models import Categoria, Producto, Carrito, Pedido, ItemPedido, ItemCarrito
from rest_framework import serializers
from django.contrib.auth import get_user_model


class ClienteSerializer(serializers.ModelSerializer):
    class Meta:
        model = get_user_model()
        fields = '__all__'


class CategoriaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Categoria
        fields = '__all__'


class ProductoSerializer(serializers.ModelSerializer):
    categoria = CategoriaSerializer()

    class Meta:
        model = Producto
        fields = '__all__'


class ProductoSaveSerializer(serializers.ModelSerializer):
    class Meta:
        model = Producto
        fields = '__all__'


class CarritoSerializer(serializers.ModelSerializer):
    cliente = serializers.SerializerMethodField('get_cliente')
    productos = ProductoSerializer(many=True)

    class Meta:
        model = Carrito
        fields = '__all__'

    def get_cliente(self, model: Carrito):
        return ClienteSerializer(model.cliente, many=False).data


class CarritoSaveSerializer(serializers.ModelSerializer):
    class Meta:
        model = Carrito
        fields = '__all__'


class ItemCarritoSerializer(serializers.ModelSerializer):
    carrito = CarritoSerializer()

    class Meta:
        model = ItemCarrito
        fields = '__all__'


class ItemCarritoSerializerSave(serializers.ModelSerializer):
    class Meta:
        model = ItemCarrito
        fields = '__all__'


class PedidoSerializer(serializers.ModelSerializer):
    cliente = serializers.SerializerMethodField('get_cliente')

    class Meta:
        model = Pedido
        fields = '__all__'

    def get_cliente(self, model: Pedido):
        return ClienteSerializer(model.cliente, many=False).data


class PedidoSaveSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pedido
        fields = '__all__'


class ItemPedidoSerializer(serializers.ModelSerializer):
    class Meta:
        model = ItemPedido
        fields = '__all__'
