# Librería Micro-ROS Arduino para Kalman

Este repositorio es una librería Micro-ROS para Arduino del Kit de Robótica Kalman.

## Instalar librería

- Clona el repositorio dentro de `lib` en la carpeta de tu proyecto platformio si estás usando PlatformIO.
- Ahora puedes incluir esta librería en tu sketch usando `#include <micro_ros_kaia.h>`.

## Modificar y reconstruir la librería Micro-ROS Arduino para Kalman
Para añadir nuevos tipos de mensajes Micro-ROS. Sigue estos pasos:
- Instala Docker para tu plataforma PC, por ejemplo [Docker para Windows](https://docs.docker.com/desktop/install/windows-install/) y asegúrate de que el agente Docker esté ejecutándose
- Clona este repositorio
- Añade el enlace github del paquete de mensajes en `extras/library_generation/extra_packages/extra_packages.repos` 
- Abre una terminal y ejecuta los siguientes comandos:
```
cd <carpeta_firmware>/lib/micro_ros_kalman

docker run -it --rm -v .\micro_ros_kaia:/project --env MICROROS_LIBRARY_FOLDER=extras microros/micro_ros_static_library_builder:iron -p esp32
```

## Reconocimientos y modificaciones
Esto está basado en [Librería Micro-ROS Arduino](https://github.com/micro-ROS/micro_ros_arduino) y [robots basados en Kaia.ai](https://github.com/kaiaai/micro_ros_arduino_kaiaai)
adaptado para Kalman. Esto incluye las siguientes modificaciones:

- corrige el script `library_generation.sh` para construir la librería correctamente en Windows
- añade interfaces personalizadas para robots Kalman
- mueve `WiFi.begin()` fuera de la librería Micro-ROS para un desarrollo de código más limpio y conveniente
- ajusta colcon.meta para optimizar características de la librería, rendimiento y uso de memoria para aplicaciones Kaia.ai

### Ajustes de API
Ahora puedes manejar la conexión a WiFi como mejor te parezca, en lugar de que Micro-ROS lo haga por ti. Por ejemplo:
```
  WiFi.begin(ssid, passw);
  Serial.print("Conectando a WiFi ");

  unsigned long startMillis = millis();
  while (WiFi.status() != WL_CONNECTED) {
    if (millis() - startMillis >= 10000) {
      Serial.println(" tiempo de espera agotado");
      return;
    }
    Serial.print('.'); // No uses F('.'), bloquea ESP32
    delay(500);
  }

  Serial.println(F(" conectado"));
  Serial.print(F("IP "));
  Serial.println(WiFi.localIP());

  set_microros_wifi_transports("192.168.1.57", 8888); // Configuración Micro-ROS
```