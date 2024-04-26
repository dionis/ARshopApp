# Generated by Django 5.0 on 2024-02-01 15:09

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('producto_app', '0021_delete_favorito'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='pedido',
            name='completado',
        ),
        migrations.RemoveField(
            model_name='producto',
            name='perteneCarrito',
        ),
        migrations.AddField(
            model_name='itempedido',
            name='precio_unitario',
            field=models.FloatField(default=0.0),
        ),
        migrations.RemoveField(
            model_name='carrito',
            name='producto',
        ),
        migrations.CreateModel(
            name='ItemCarrito',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('cantidad', models.IntegerField(default=1)),
                ('carrito', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='producto_app.carrito')),
                ('producto', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='producto_app.producto')),
            ],
        ),
        migrations.AddField(
            model_name='carrito',
            name='producto',
            field=models.ManyToManyField(through='producto_app.ItemCarrito', to='producto_app.producto'),
        ),
    ]
