from django.contrib import admin
from .models import Categoria, Producto, Carrito, Pedido, ItemPedido, ItemCarrito
from django.db import models

# Register your models here.

admin.site.register(Categoria)
# admin.site.register(Producto)
admin.site.register(Carrito)
admin.site.register(Pedido)
admin.site.register(ItemCarrito)
admin.site.register(ItemPedido)


class ProductoAdmin(admin.ModelAdmin):
    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == "categoria":
            kwargs["queryset"] = Categoria.objects.exclude(nombre="Todos")
        return super().formfield_for_foreignkey(db_field, request, **kwargs)

admin.site.register(Producto, ProductoAdmin)
