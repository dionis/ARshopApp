from django.urls import path
from . import views

urlpatterns = [
    path('getListOfCategoria/', views.CategoriaAPI.as_view()),
    path('getListOfProducto/', views.ProductoAPI.as_view()),
    path('buscarProducto/<productonombre>/',
         views.BuscarProductoAPI.as_view()),
    path('geListOfProducto_x_Categoria/<categoria>/',
         views.ProductoCategoriaAPI.as_view()),
    path('getListOfEntidades/', views.EntidadAPI.as_view()),
    path('geListOfProducto_x_Entidad/<entidad>/',
         views.ProductoEntidadAPI.as_view()),
]
