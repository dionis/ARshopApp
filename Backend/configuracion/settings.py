"""
Django settings for configuracion project.

Generated by 'django-admin startproject' using Django 5.0.

For more information on this file, see
https://docs.djangoproject.com/en/5.0/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/5.0/ref/settings/
"""

from decouple import config
from pathlib import Path
import os

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/5.0/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'django-insecure-c_37tv)str0fb)zm5wpqjpln5c*vq!4p&70i)f8x9q(3)h#*+4'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ['*']

# Application definition

INSTALLED_APPS = [
    # 'admin_interface',
    'jazzmin',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'corsheaders',
    # 'colorfield',


    # restful app
    'rest_framework',
    # 'rest_auth',

    # local app
    'user_app.apps.UserAppConfig',
    'producto_app',

    # auth app
    'rest_framework.authtoken',
    'dj_rest_auth',

    # register app
    'django.contrib.sites',
    'allauth',
    'allauth.account',
    'allauth.socialaccount',
    'dj_rest_auth.registration',

]

SITE_ID = 1
# X_FRAME_OPTIONS = 'SAMEORIGIN'

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'allauth.account.middleware.AccountMiddleware',
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.common.CommonMiddleware',
]

ROOT_URLCONF = 'configuracion.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [ os.path.join(BASE_DIR, 'templates')],
        # os.path.join(BASE_DIR, 'templates')
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'configuracion.wsgi.application'


# Database
# https://docs.djangoproject.com/en/5.0/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'HOST': 'localhost',
        'PORT': '3306',
        'USER': 'root',
        'PASSWORD': 'mysql',
        'NAME': 'bd_arshop',
        'OPTIONS': {
            'init_command': "SET sql_mode='STRICT_TRANS_TABLES'",
        }
    }
}


# Password validation
# https://docs.djangoproject.com/en/5.0/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/5.0/topics/i18n/

LANGUAGE_CODE = 'es'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/5.0/howto/static-files/

STATIC_URL = 'static/'
STATICFILES_DIRS = [os.path.join(BASE_DIR, "static")]

# Default primary key field type
# https://docs.djangoproject.com/en/5.0/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

AUTH_USER_MODEL = 'user_app.User'

CORS_ALLOW_ALL_ORIGINS = True

AUTHENTICATION_BACKENDS = (
    'django.contrib.auth.backends.ModelBackend',

    'allauth.account.auth_backends.AuthenticationBackend'
)

# Configuracion para enviar email de confirmacion
# EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_PORT = 587
EMAIL_USE_TLS = True
# EMAIL_HOST_USER = 'yilbertbenitez2001@gmail.com'
# # config('EMAIL_HOST_USER')
# EMAIL_HOST_PASSWORD = 'enter your password'
# # config('EMAIL_HOST_PASSWORD')
ACCOUNT_EMAIL_VERIFICATION = 'mandatory'
ACCOUNT_LOGIN_ON_EMAIL_CONFIRMATION = True


ACCOUNT_AUTHENTICATION_METHOD = 'email'
ACCOUNT_EMAIL_REQUIRED = True
ACCOUNT_UNIQUE_EMAIL = True
ACCOUNT_USERNAME_REQUIRED = False
ACCOUNT_USER_MODEL_USERNAME_FIELD = None
USERNAME_REQUIRED = False
ACCOUNT_EMAIL_VERIFICATION = None
ACCOUNT_CONFIRM_EMAIL_ON_GET = False


REST_AUTH = {
    'SESSION_LOGIN': False,
    'LOGIN_SERIALIZER': 'user_app.serializers.NewLoginSerializers',
    'REGISTER_SERIALIZER': 'user_app.serializers.NewRegisterSerializers',
    'USER_DETAILS_SERIALIZER': 'user_app.serializers.NewUserDetailsSerializer',
}


REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': [
        'rest_framework.authentication.SessionAuthentication',
        'rest_framework.authentication.TokenAuthentication',
    ]
}


MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, "media")


JAZZMIN_SETTINGS = {
    "site_title": "ARShop Admin",

    "site_brand": "ARShop Admin",

    "site_logo": "ic_launcher.png",

    "welcome_sign": "Bienvenido al panel de Administracion de ARShop.",

    "copyright": "ARShop",

    # "search_model": ["producto_app.Producto"],

    "topmenu_links": [
        {"name": "Principal", "url": "admin:index"},
        {"model": "producto_app.Categoria"},
        {"model": "producto_app.Producto"},
    ],

    "navigation_expanded": True,

    # "hide_apps": ["auth", "sites", "socialaccount", "authtoken", "account"],

    "order_with_respect_to": ["producto_app.Categoria", "producto_app.Producto"],
}

JAZZMIN_UI_TWEAKS = {
    "theme": "darkly",
}
