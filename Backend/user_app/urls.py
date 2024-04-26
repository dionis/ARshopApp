from django.urls import path, include
from dj_rest_auth import urls
from dj_rest_auth.registration.views import VerifyEmailView

urlpatterns = [
    path('auth/', include('dj_rest_auth.urls')),
    path('auth/registration/', include('dj_rest_auth.registration.urls')),
    path('auth/confirm-email/', VerifyEmailView.as_view(),
         name='account_email_verification_sent')
]
