# Generated by Django 3.2.23 on 2024-02-21 05:06

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('producto_app', '0025_producto_pertenececarrito'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='producto',
            name='perteneceCarrito',
        ),
    ]
