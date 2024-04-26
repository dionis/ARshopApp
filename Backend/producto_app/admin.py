from django.contrib import admin
from .models import Categoria, Producto, Carrito, Pedido, ItemPedido, ItemCarrito
from django.db import models
# Register your models here.


admin.site.register(Categoria)
admin.site.register(Producto)
admin.site.register(Carrito)
admin.site.register(Pedido)
admin.site.register(ItemCarrito)
admin.site.register(ItemPedido)
