# PNet

[![Licencia MIT](https://img.shields.io/badge/Licencia-MIT-blue.svg)](LICENSE)
![Hecho con Processing](https://img.shields.io/badge/Hecho%20con-Processing-orange.svg)

<img width="800" height="555" alt="image" src="https://github.com/user-attachments/assets/9d85fd87-1060-4a21-bffa-7bc78a9a634b" />

**Repositorio:** [https://github.com/jizaga/pnet](https://github.com/jizaga/pnet)

## Descripción

**PNet** es una aplicación desarrollada en **Processing v4** que permite **monitorear el estado de los dispositivos de control de una planta solar** mediante el protocolo **ICMP (ping)**.  
Su propósito es ofrecer una forma sencilla y visual de verificar la disponibilidad de los equipos dentro de una red local o remota.

---

## Tecnologías utilizadas

- **Lenguaje:** [Processing v4](https://processing.org/)
- **Protocolo de comunicación:** ICMP (ping)
- **Sistema operativo compatible:** Windows, Linux o macOS (con soporte para Processing)

---

## Requisitos previos

- Tener instalado **Processing v4** o una versión compatible.  
  Descarga disponible en: [https://processing.org/download](https://processing.org/download)
- No se requieren librerías adicionales ni dependencias externas.

---

## Instalación

1. Clona este repositorio en tu equipo local:

   ```bash
   git clone https://github.com/jizaga/pnet.git

   ```

2. Abre el proyecto en el IDE de Processing.

3. Ejecuta el archivo principal pnet.pde.

pnet/  
│  
├── pnet.pde # Archivo principal del programa  
├── funciones.pde # Funciones auxiliares utilizadas por la aplicación  
├── pantallas.pde # Gestión de las pantallas e interfaz gráfica  
│  
└── data/ # Recursos gráficos (iconos, logotipos y elementos visuales)

## Uso

1. Ejecuta el programa desde Processing.

2. La aplicación realizará solicitudes ICMP a los dispositivos configurados.

3. El estado de los equipos se mostrará en la interfaz visual mediante iconos de estado.

## Autor

Joseba Izaga

Desarrollador y mantenedor del proyecto.

## Licencia

Este proyecto se distribuye bajo los términos de la licencia MIT.
Consulta el archivo [LICENSE](./LICENSE)
para más información.
