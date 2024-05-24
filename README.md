# Tesis

A la hora de compilar la app al movil si le da el siguiente error

The Android Gradle plugin supports only Kotlin Gradle plugin version 1.5.20 and higher.
The following dependencies do not satisfy the required version:
project ':arcore_flutter_plugin' -> org.jetbrains.kotlin:kotlin-gradle-plugin:1.3.50


Se debe al plugin de realidad aumentada ‘ar_flutter_plugin’ debido a que este plugin en uno de sus archivos tiene una versión de kotlin 1.3.50 la cual es incompatible con la version de gradle que se especifica al crear un proyecto por defecto.

Para solucionarlo debes actualizar la versión del complemento Kotlin Gradle a 1.5.20 o superior. Para hacerlo debe seguir estos pasos:

    1. Desde la consola dirigirse a la carpeta Android del proyecto con el comando: cd android/

    2. Luego ejecutar el siguiente comando el cual encontrara el archivo que está usando esta versión de kotlin: ./gradlew clean --warning-mode fail

    3. Abrir el archivo que indica el comando

    4. Una vez localizado el archivo actualizar la versión de kotlin según la tenga por defecto el proyecto (para saber esto dirigirse al archivo settings.gradle) y guardar cambios.

    5. Ejecutar el comando ./gradlew clean 
