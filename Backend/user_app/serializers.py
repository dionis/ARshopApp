from rest_framework.views import APIView
from rest_framework.response import Response
from dj_rest_auth.serializers import LoginSerializer
from dj_rest_auth.registration.serializers import RegisterSerializer, get_adapter
from rest_framework import serializers, status
from dj_rest_auth.serializers import UserDetailsSerializer
from django.contrib.auth import authenticate, get_user_model
from django.db import IntegrityError


UserModel = get_user_model()


class EmailAlreadyExitsError(serializers.ValidationError):
    default_code = 'email_already_exists'
    default_detail = 'La direccion de correo de elctronico ya existe'


class NewUserDetailsSerializer(UserDetailsSerializer):
    class Meta:
        model = UserModel
        fields = ('id', 'first_name', 'last_name', 'direccion',
                  'telefono', 'email', )

    def update(self, instance, validated_data):
        # Actualiza los campos del modelo User
        instance = super().update(instance, validated_data)
        return instance


class NewRegisterSerializers(RegisterSerializer):
    first_name = serializers.CharField()
    last_name = serializers.CharField()
    direccion = serializers.CharField()
    telefono = serializers.CharField()
    # # imagenU = serializers.ImageField()

    def custom_signup(self, request, user):
        user.first_name = request.data['first_name']
        user.last_name = request.data['last_name']
        user.direccion = request.data['direccion']
        user.telefono = request.data['telefono']
        try:
            user.save()
        except IntegrityError:
            raise EmailAlreadyExitsError()

    def validate(self, attrs):
        email = attrs.get('email')
        if UserModel.objects.filter(email=email).exists():
            raise serializers.ValidationError({
                'email_already_exists': {
                    'La dirección de correo electrónico ya está en uso.'
                }
            })
        return attrs


class NewLoginSerializers(LoginSerializer):
    pass


class CustomRegisterView(APIView):
    def post(self, request, *args, **kwargs):
        serializer = NewRegisterSerializers(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def handle_exception(self, exc):
        if isinstance(exc, EmailAlreadyExistsError):
            return Response({'email': [exc.default_detail]}, status=status.HTTP_400_BAD_REQUEST)
        return super().handle_exception(exc)
