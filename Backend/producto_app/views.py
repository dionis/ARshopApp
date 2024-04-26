from .serializers import ProductoSerializer
from .models import Carrito
from .serializers import CarritoSerializer
from .models import Carrito, Producto
from rest_framework import generics, status
from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import (CategoriaSerializer,
                          ProductoSerializer,
                          ProductoSaveSerializer,
                          PedidoSerializer,
                          PedidoSaveSerializer,
                          ItemPedidoSerializer,
                          CarritoSerializer,
                          CarritoSaveSerializer,
                          ItemCarritoSerializer,
                          ItemCarritoSerializerSave
                          )
from rest_framework.generics import (CreateAPIView,
                                     UpdateAPIView,
                                     DestroyAPIView,
                                     ListAPIView,
                                     RetrieveUpdateDestroyAPIView,
                                     ListCreateAPIView,
                                     RetrieveAPIView
                                     )
from .models import Producto, Categoria, Pedido, Carrito, ItemPedido, ItemCarrito
from django.contrib.auth import get_user_model
from django.contrib.auth.models import User
# Empieza el Trabajo con las categorias


class CreateCategoriaAPI(CreateAPIView):
    serializer_class = CategoriaSerializer


class CategoriaAPI(ListAPIView):
    serializer_class = CategoriaSerializer
    queryset = Categoria.objects.all()


class CategoriaRetrieveUpdateDestroyAPIView(RetrieveUpdateDestroyAPIView):
    serializer_class = CategoriaSerializer
    queryset = Categoria.objects.all()
    lookup_field = 'id'
# Termina el Trabajo con las categorias


# Empieza el Trabajo con los Productos
class ProductoAPI(ListAPIView):
    serializer_class = ProductoSerializer
    queryset = Producto.objects.all()


class ProductoCategoriaAPI(ListAPIView):
    serializer_class = ProductoSerializer

    def get_queryset(self):
        categoria_id = self.kwargs['categoria']
        queryset = Producto.objects.filter(categoria=categoria_id)
        return queryset


class ProductoRecomendadosAPI(ListAPIView):
    serializer_class = ProductoSerializer
    queryset = Producto.objects.filter(recomendados=True)


class BuscarProductoAPI(ListAPIView):
    serializer_class = ProductoSerializer

    def get_queryset(self):
        nombre_prod = self.kwargs['productonombre']
        queryset = Producto.objects.filter(nombre__icontains=nombre_prod)
        return queryset


class buscarProductoCarrito(generics.RetrieveAPIView):
    queryset = Producto.objects.all()
    serializer_class = ProductoSerializer

    def get(self, request, *args, **kwargs):
        usuario_id = kwargs.get('usuario_id')
        producto_id = kwargs.get('producto_id')

        try:
            carrito = Carrito.objects.get(cliente=usuario_id)
            item_carrito = ItemCarrito.objects.filter(
                carrito=carrito, producto=producto_id).first()

            return Response(bool(item_carrito), status=200)
        except Carrito.DoesNotExist:
            return Response(False, status=404)



class CreateCarritoAPI(CreateAPIView):
    serializer_class = ItemCarritoSerializerSave

    def post(self, request, *args, **kwargs):
        producto_id = request.data.get('producto_id')

        carrito, creado = Carrito.objects.get_or_create(cliente=request.user)

        try:
            producto = Producto.objects.get(id=producto_id)
        except Producto.DoesNotExist:
            return Response({"message": "El producto no existe."}, status=400)

        item_carrito, created = ItemCarrito.objects.get_or_create(
            carrito=carrito, producto=producto)
        if created:
            return Response({"message": "Producto agregado al carrito exitosamente."}, status=201)
        else:
            return Response({"message": "El producto ya está en el carrito."}, status=400)


class CarritoAPI(RetrieveAPIView):
    queryset = Carrito.objects.all()
    serializer_class = ProductoSerializer
    lookup_field = 'cliente'

    def retrieve(self, request, *args, **kwargs):
        carrito = self.get_object()
        productos = carrito.productos.all()
        serializer = self.get_serializer(productos, many=True)
        return Response(serializer.data)


class DeleteCarritoAPI(DestroyAPIView):
    queryset = ItemCarrito.objects.all()
    serializer_class = ItemCarritoSerializer

    def delete(self, request, *args, **kwargs):
        user = request.user
        producto_id = kwargs.get('producto_id')

        try:
            carrito = Carrito.objects.get(cliente=user)
            item_carrito = ItemCarrito.objects.get(
                carrito=carrito, producto_id=producto_id)
        except Carrito.DoesNotExist:
            return Response({"error": "No se encontró un carrito asociado al usuario"}, status=status.HTTP_404_NOT_FOUND)
        except ItemCarrito.DoesNotExist:
            return Response({"error": "Producto no encontrado en el carrito"}, status=status.HTTP_404_NOT_FOUND)

        item_carrito.delete()
        return Response({"message": "Producto eliminado del carrito exitosamente"}, status=status.HTTP_204_NO_CONTENT)
