from django.db import models
from user_app.models import User
from django.contrib.auth import get_user_model

# Create your models here.

class Categoria(models.Model):
    nombre = models.CharField(max_length=100)
    imagenC = models.ImageField(upload_to='categorias/')

    def __str__(self):
        return self.nombre


class Producto(models.Model):
    nombre = models.CharField(max_length=100)
    descripcion = models.TextField()
    categoria = models.ForeignKey(
        Categoria, on_delete=models.CASCADE)
    precio = models.FloatField()
    imagenP = models.ImageField(upload_to='Productos/')
    modelo_3d = models.FileField(
        upload_to='modelos', )
    cantidad_disponible = models.IntegerField()
    recomendados = models.BooleanField(default=False)

    def __str__(self):
        return str(self.id) + ':  '+self.nombre


class Carrito(models.Model):
    cliente = models.ForeignKey(get_user_model(), on_delete=models.CASCADE)
    productos = models.ManyToManyField(Producto, through='ItemCarrito')


class ItemCarrito(models.Model):
    carrito = models.ForeignKey(Carrito, on_delete=models.CASCADE)
    producto = models.ForeignKey(Producto, on_delete=models.CASCADE)
    # cantidad = models.PositiveIntegerField(default=1)


class Pedido(models.Model):
    cliente = models.ForeignKey(get_user_model(), on_delete=models.CASCADE)
    productos = models.ManyToManyField(Producto, through='ItemPedido')
    direccion_envio = models.TextField()
    fecha_pedido = models.DateTimeField(auto_now_add=True)
    # completado = models.BooleanField(default=False)


class ItemPedido(models.Model):
    producto = models.ForeignKey(Producto, on_delete=models.CASCADE)
    pedido = models.ForeignKey(Pedido, on_delete=models.CASCADE)
    cantidad = models.PositiveIntegerField(default=1)
    precio_unitario = models.FloatField(default=0.0)
