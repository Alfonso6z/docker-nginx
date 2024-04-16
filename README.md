# Nginx en Docker

Este repositorio contiene ejemplos y configuraciones para trabajar con Nginx dentro de contenedores Docker.

## Menú

1. [Introducción a Nginx en Docker](#introducción-a-nginx-en-docker)
2. [Ejemplos](#ejemplos)
    - [Reverse Proxy](reverse-proxy/README.md)
    <!-- - [Balanceo de Carga](balanceo-carga/README.md)
    - [Servidor Estático](servidor-estático/README.md) -->
3. [Contribución](#contribución)
4. [Licencia](#licencia)

## Introducción a Nginx en Docker

Nginx es un servidor web ligero, de alto rendimiento y escalable, así como un proxy inverso y un servidor para servir contenido estático. Docker es una plataforma que permite empaquetar, distribuir y ejecutar aplicaciones en contenedores.

Al combinar Nginx con Docker, podemos crear entornos de desarrollo, pruebas y producción altamente flexibles y escalables para nuestras aplicaciones web.

Este repositorio proporciona ejemplos y configuraciones listas para usar que te ayudarán a empezar a trabajar con Nginx en Docker de manera efectiva.

## Ejemplos

### Reverse Proxy

El ejemplo de reverse proxy muestra cómo configurar Nginx como un proxy inverso para dirigir el tráfico entrante a diferentes aplicaciones en función del nombre del host o de la ruta.

Más detalles: [Reverse Proxy](reverse-proxy/README.md)

### Balanceo de Carga

El ejemplo de balanceo de carga muestra cómo configurar Nginx para distribuir la carga entre varios servidores de aplicaciones, mejorando así la escalabilidad y la disponibilidad de nuestras aplicaciones.

<!-- Más detalles: [Balanceo de Carga](balanceo-carga/README.md) -->

### Servidor Estático

El ejemplo de servidor estático muestra cómo utilizar Nginx para servir contenido estático, como archivos HTML, CSS, JavaScript e imágenes.

<!-- Más detalles: [Servidor Estático](servidor-estático/README.md) -->

## Contribución

¡Las contribuciones son bienvenidas! Si tienes ideas, sugerencias o mejoras para estos ejemplos, no dudes en abrir un problema o enviar una solicitud de extracción.

## Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.
