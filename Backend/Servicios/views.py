from django.shortcuts import render
from rest_framework import generics, status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import (CategoriaSerializer,
                          ProductoSerializer,
                          ProductoSaveSerializer,
                          EntidadSerializer)
from rest_framework.generics import (CreateAPIView,
                                     UpdateAPIView,
                                     DestroyAPIView,
                                     ListAPIView,
                                     RetrieveUpdateDestroyAPIView,
                                     ListCreateAPIView,
                                     RetrieveAPIView
                                     )
from .models import Producto, Categoria, Entidad

# Create your views here.


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


class BuscarProductoAPI(ListAPIView):
    serializer_class = ProductoSerializer

    def get_queryset(self):
        nombre_prod = self.kwargs['productonombre']
        queryset = Producto.objects.filter(nombre__icontains=nombre_prod)
        return queryset


class EntidadAPI(ListAPIView):
    serializer_class = EntidadSerializer
    queryset = Entidad.objects.all()


class ProductoEntidadAPI(ListAPIView):
    serializer_class = ProductoSerializer

    def get_queryset(self):
        entidad_id = self.kwargs['entidad']
        queryset = Producto.objects.filter(entidad=entidad_id)
        return queryset
