from django.urls import path
from . import views

urlpatterns = [
    #     path('createCategoria/', views.CreateCategoriaAPI.as_view()),
    #     path('deleteUpdateCategoria/<pk>',
    #     views.CategoriaRetrieveUpdateDestroyAPIView.as_view()),
    path('getListOfCategoria/', views.CategoriaAPI.as_view()),
    path('getListOfProducto/', views.ProductoAPI.as_view()),
    path('getListOfProductoRecomendados/',
         views.ProductoRecomendadosAPI.as_view()),
    path('buscarProducto/<productonombre>/',
         views.BuscarProductoAPI.as_view()),
    path('buscarProductoCarrito/<producto>/',
         views.buscarProductoCarrito.as_view()),
    path('geListOfProducto_x_Categoria/<categoria>/',
         views.ProductoCategoriaAPI.as_view()),
    path('createCarrito/', views.CreateCarritoAPI.as_view()),
    path('getListCarrito/<cliente>/', views.CarritoAPI.as_view()),
    path('buscarProductoCarrito/<int:usuario_id>/<int:producto_id>/',
         views.buscarProductoCarrito.as_view()),
    path('deleteCarrito/<int:producto_id>/',
         views.DeleteCarritoAPI.as_view()),
]
