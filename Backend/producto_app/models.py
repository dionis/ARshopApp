from django.db import models
from user_app.models import User
from django.contrib.auth import get_user_model
from django.db.models.signals import post_save
from django.dispatch import receiver
import os
from django.conf import settings
from django.core.files import File

# Create your models here.

class Categoria(models.Model):
    nombre = models.CharField(max_length=100)
    imagenC = models.ImageField(upload_to='categorias/')

    def __str__(self):
        return self.nombre

@receiver(post_save, sender=Categoria)
def crear_categoria_todos(sender, instance, created, **kwargs):
    if created and instance.nombre != 'todos':
        # Crear la categoría "todos" si se crea una categoría distinta a "todos"
        todos_categoria, created = Categoria.objects.get_or_create(nombre='todos')
        
        # Asignar una imagen por defecto a la categoría "todos" si no tiene una imagen
        if created or not todos_categoria.imagenC:
            # Ruta de la imagen por defecto en la carpeta media del proyecto
            imagen_por_defecto = os.path.join(settings.MEDIA_ROOT, 'categorias', 'todas_las_categorias.png')
            # Asignar la imcategoriasagen por defecto a la categoría "todos"
            todos_categoria.imagenC.save(os.path.basename(imagen_por_defecto), File(open(imagen_por_defecto, 'rb')), save=False)
            todos_categoria.save()

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
