from django.db import models
from django.db.models.signals import post_save
from django.dispatch import receiver
import os
from django.conf import settings
from django.core.files import File
from phonenumber_field.modelfields import PhoneNumberField
from django.core.validators import FileExtensionValidator

# Create your models here.


class Categoria(models.Model):
    nombre = models.CharField(max_length=100)
    imagenC = models.ImageField(upload_to='categorias/')

    def __str__(self):
        return self.nombre


class Entidad(models.Model):
    logo = models.ImageField(upload_to='Entidad/')
    nombre = models.CharField(max_length=100)
    direccion = models.CharField(max_length=100)
    telefono = PhoneNumberField()
    descripcion = models.TextField()
    paginaOficial = models.URLField(max_length=200)

    def __str__(self):
        return self.nombre


class Producto(models.Model):

    UNIDAD_PULGADAS = 'in'
    UNIDAD_METROS = 'm'
    UNIDAD_CM = 'cm'

    UNIDADES_OPCIONES = [
        (UNIDAD_PULGADAS, 'Pulgadas'),
        (UNIDAD_METROS, 'Metros'),
        (UNIDAD_CM, 'Centímetros'),
    ]

    nombre = models.CharField(max_length=100)
    descripcion = models.TextField()
    categoria = models.ForeignKey(
        Categoria, on_delete=models.CASCADE)
    precio = models.FloatField()
    imagenP = models.ImageField(upload_to='Productos/')
    modelo_3d = models.FileField(
        upload_to='modelos', validators=[FileExtensionValidator(allowed_extensions=['glb', 'gltf'])])
    # paginaComprar = models.URLField(max_length=200)
    entidad = models.ForeignKey(
        Entidad, on_delete=models.DO_NOTHING)
    ancho = models.FloatField()
    alto = models.FloatField()
    largo = models.FloatField()
    unidadM = models.CharField(
        max_length=2,
        choices=UNIDADES_OPCIONES,
        default=UNIDAD_METROS,
    )

    def __str__(self):
        return str(self.id) + ':  '+self.nombre

    def clean(self):
        super().clean()

        if self.unidadM == self.UNIDAD_PULGADAS:
            self.ancho /= 0.0254
            self.alto /= 0.0254
            self.largo /= 0.0254
        elif self.unidadM == self.UNIDAD_CM:
            self.ancho *= 0.01
            self.alto *= 0.01
            self.largo *= 0.01
