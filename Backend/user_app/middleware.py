# import random
# from django.utils.deprecation import MiddlewareMixin
# from django.core.mail.backends.smtp import EmailBackend

# class BaseCustomEmailBackend:
#     def generate_verification_code(self):
#         # Método para generar un código de verificación
#         return ''.join(random.choices('0123456789', k=4))



# class CombinedCustomEmailBackend(BaseCustomEmailBackend):
#     def __init__(self, email_backend, get_response):
#         super().__init__()
#         self.email_backend = email_backend
#         self.get_response = get_response

#     def send_mail(self, *args, **kwargs):
#         message = self.email_backend.send_mail(*args, **kwargs)
#         if "Verification Code" in message.body:
#             verification_code = self.generate_verification_code()
#             message.body = message.body.replace("Verification Code", str(verification_code))
#         return message

#     def __call__(self, request):
#         # Implementa la lógica del middleware aquí
#         response = self.get_response(request)
#         return response




# class CustomEmailMiddleware(MiddlewareMixin):
#     def __init__(self, get_response):
#         super().__init__(get_response)
#         self.backend = CombinedCustomEmailBackend(get_response=self.process_request)