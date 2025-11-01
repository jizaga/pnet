# PNet

[![Licencia MIT](https://img.shields.io/badge/Licencia-MIT-blue.svg)](LICENSE)
![Hecho con Processing](https://img.shields.io/badge/Hecho%20con-Processing-orange.svg)
![Badge en Desarollo](https://img.shields.io/badge/STATUS-EN%20DESAROLLO-green)

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

pnet  
│  
├── pnet.pde # Archivo principal del programa  
├── funciones.pde # Funciones auxiliares utilizadas por la aplicación  
├── pantallas.pde # Gestión de las pantallas e interfaz gráfica  
│  
└── data/ # Recursos gráficos (iconos, logotipos y elementos visuales)  
&emsp;&emsp;│  
&emsp;&emsp;├── dispositivos.json # Lista de los dispositivos a monitorear  
&emsp;&emsp;├── var.json # Lista de las variables de operación del sistema  
&emsp;&emsp;└── *.png # Recursos gráficos (iconos, logotipos y elementos visuales)

## Uso

1. Ejecuta el programa desde Processing.

2. La aplicación realizará solicitudes ICMP a los dispositivos configurados.

3. El estado de los equipos se mostrará en la interfaz visual mediante iconos de estado.

4. Al hacer doble-click en el nombre de una de los elementos de red, aparecerá una ventana que le permitirá cambiar el nombre y el IP del elemento, mantenimiendo el formato nombre@IP. Estos cambios se almacenarán en el archivo dispositivo.json.

<img width="324" height="145" alt="image" src="https://github.com/user-attachments/assets/83ea9a60-a64e-4420-bc8e-2d73301ed920" />

5. Al hacer doble-click en la casilla del tiempo de muestreo, inicialmente con el valor de 8 segundos, aparecerá una ventana que le permitirá cambiar el tiempo de muestreo. Introducir un valor en segundos. Se recomienda que el tiempo míno no sea menor a los 630 segundos para un monitoreo contínuo.

<img width="327" height="150" alt="image" src="https://github.com/user-attachments/assets/0050a477-99c9-4d47-a590-c021dd2eabef" />

6. El botón "REFRESCAR" ejecutará un monitoreo completo de la red en el momento que se presiones, poniendo a cero el contador del tiempo transcurrido.

<img width="125" height="45" alt="image" src="https://github.com/user-attachments/assets/e21cae63-28fd-4fe4-8e7e-2c38942e8ad4" />

## Autor

Joseba Izaga

Desarrollador y mantenedor del proyecto.

## Licencia

Este proyecto se distribuye bajo los términos de la licencia MIT.
Consulta el archivo [LICENSE](./LICENSE)
para más información.
