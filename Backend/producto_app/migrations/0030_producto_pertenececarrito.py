# Generated by Django 3.2.23 on 2024-02-24 04:13

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('producto_app', '0029_auto_20240221_0030'),
    ]

    operations = [
        migrations.AddField(
            model_name='producto',
            name='perteneceCarrito',
            field=models.BooleanField(default=False),
        ),
    ]
