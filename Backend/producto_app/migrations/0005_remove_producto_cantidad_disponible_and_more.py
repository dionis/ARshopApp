# Generated by Django 5.0.6 on 2024-06-15 05:03

import phonenumber_field.modelfields
from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('producto_app', '0004_alter_entidad_logo'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='producto',
            name='cantidad_disponible',
        ),
        migrations.RemoveField(
            model_name='producto',
            name='recomendados',
        ),
        migrations.AlterField(
            model_name='entidad',
            name='telefono',
            field=phonenumber_field.modelfields.PhoneNumberField(max_length=128, region=None),
        ),
    ]