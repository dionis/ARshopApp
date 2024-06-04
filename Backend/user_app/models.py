from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.

class User(AbstractUser):
    imagenU = models.ImageField(upload_to='User/', blank=True, null=True)
    username = models.CharField(max_length=55, unique=False, blank=True,null=True)
    email = models.EmailField(unique=True)
    direccion = models.CharField(max_length=200)
    telefono = models.CharField(max_length=50)

    def __str__(self) -> str:
        return self.first_name+': '+str(self.id)
