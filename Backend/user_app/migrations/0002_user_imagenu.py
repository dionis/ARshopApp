# Generated by Django 3.2.23 on 2024-05-16 02:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('user_app', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='imagenU',
            field=models.ImageField(default='user default.png', upload_to='User/'),
        ),
    ]
