# Configuración de Reverse Proxy con Docker y Nginx

Un reverse proxy, o proxy inverso, es una herramienta esencial en el arsenal de cualquier desarrollador web moderno. Actúa como intermediario entre los clientes y los servidores de origen, direccionando las solicitudes entrantes a los servidores adecuados según ciertos criterios, como la dirección URL o la cabecera de la solicitud.

En este repositorio, proporcionamos un ejemplo de cómo configurar un reverse proxy utilizando Docker y Nginx. Este conjunto de archivos permite crear y ejecutar fácilmente un entorno de desarrollo que incluye un proxy inverso y varias aplicaciones web backend.

## ¿Por qué usar un Reverse Proxy?

- **Balanceo de carga:** Distribuye las solicitudes entrantes entre múltiples servidores backend para mejorar el rendimiento y la capacidad de respuesta del sistema.
- **Seguridad:** Actúa como un punto de entrada único y puede proporcionar capas adicionales de seguridad, como filtrado de solicitudes, cifrado SSL y protección contra ataques DDoS.
- **Gestión de múltiples aplicaciones:** Permite alojar varias aplicaciones en el mismo servidor y dirigir el tráfico a la aplicación correcta según la URL solicitada.
- **Escalabilidad:** Facilita la adición o eliminación de servidores backend según sea necesario para manejar cambios en la carga de trabajo.

# Creación del Archivo Dockerfile
**Para la sección "proxy":**

1. **Definición de la Imagen Base:** Se utiliza la imagen base de Nginx con la etiqueta alpine3.18 y se le asigna el nombre "proxy".

2. **Exposición del Puerto 80:** Se especifica que el contenedor estará escuchando en el puerto 80 para permitir la comunicación con otras aplicaciones.

3. **Creación del Directorio para Sitios Habilitados:** Se crea el directorio `/etc/nginx/sites-enabled/` dentro del contenedor para almacenar los archivos de configuración de los sitios web habilitados.

4. **Copia de Archivos Estáticos del Sitio Web:** Se copian los archivos estáticos del sitio web desde el directorio `proxy/html` del contexto de construcción al directorio de documentos raíz de Nginx en el contenedor.

5. **Copia de Archivos de Configuración de los Sitios Web:** Se copian los archivos de configuración de los sitios web desde los directorios `app-uno` y `app-dos` del contexto de construcción al directorio de configuración de Nginx en el contenedor.

6. **Creación de Enlaces Simbólicos:** Se crean enlaces simbólicos desde los archivos de configuración en `/etc/nginx/sites-available/` a `/etc/nginx/sites-enabled/` para habilitar los sitios web.

7. **Copia del Archivo de Configuración General de Nginx:** Se copia el archivo de configuración general de Nginx desde el directorio `proxy` del contexto de construcción al directorio de configuración de Nginx en el contenedor.

8. **Comando de Inicio del Contenedor:** Se especifica el comando que se ejecutará cuando el contenedor se inicie, que en este caso es iniciar Nginx en primer plano.

**Para las secciones "app-uno" y "app-dos":**

1. **Definición de la Imagen Base:** Se utiliza la imagen base de Nginx con la etiqueta alpine3.18-slim y se le asignan los nombres "app-uno" y "app-dos" respectivamente.

2. **Eliminación del Archivo de Configuración Predeterminado:** Se elimina el archivo de configuración predeterminado de Nginx para evitar conflictos con los archivos de configuración personalizados.

3. **Copia de Archivos Estáticos del Sitio Web:** Se copian los archivos estáticos del sitio web desde los directorios `app-uno/html` y `app-dos/html` del contexto de construcción al directorio de documentos raíz de Nginx en el contenedor correspondiente.

4. **Copia del Archivo de Configuración de Nginx:** Se copia el archivo de configuración específico de Nginx desde los directorios `app-uno` y `app-dos` del contexto de construcción al directorio de configuración de Nginx en el contenedor correspondiente.

5. **Comando de Inicio del Contenedor:** Se especifica el comando que se ejecutará cuando el contenedor se inicie, que en este caso es iniciar Nginx en primer plano.

Cada paso está explicado con comentarios en el Dockerfile para facilitar su comprensión.

# Creación de docker-compose.yml

En este paso, creamos el archivo `docker-compose.yml`, que es un archivo de configuración para Docker Compose. Este archivo permite definir y ejecutar aplicaciones Docker con múltiples contenedores de manera fácil y consistente.

Para ejecutar la aplicación definida en el archivo `docker-compose.yml`, simplemente ejecutamos el comando `docker-compose up` en la terminal dentro del directorio donde se encuentra el archivo `docker-compose.yml`.

Dentro del archivo `docker-compose.yml`, encontrarás los servicios definidos, como `proxy`, `app-uno` y `app-dos`, junto con sus configuraciones correspondientes, como la construcción de imágenes, mapeo de puertos, nombres de contenedores y reinicio automático.

# Creación de la configuración del nginx.conf

En este paso, creamos la configuración del servidor Nginx para el proxy y las aplicaciones individuales.

Para el archivo `nginx.conf` del proxy, incluiremos la directiva `include /etc/nginx/sites-enabled/*;`, que permitirá incluir todos los archivos de configuración de los sitios habilitados en la carpeta `/etc/nginx/sites-enabled/`.

Para cada aplicación, como en el caso de `app-uno.com`, crearemos un archivo de configuración específico. Este archivo define cómo se manejarán las solicitudes para el dominio específico de la aplicación.

A continuación, se muestra un ejemplo de cómo se vería el archivo `nginx.conf` del proxy y el archivo `app-uno.com.conf`:

```yml
server {
  # Escucha en el puerto 80, ipv4.
  listen 80; 
  
  # Aquí deberás introducir el nombre de tu dominio.
  server_name app-uno.com;

  # Ruta del archivo de registro de acceso para la aplicación.
  access_log /var/log/nginx/app-uno.com.access.log;

  # Define cómo se manejarán las solicitudes para la ubicación raíz (/).
  location / {
      # Configuración del proxy para redirigir las solicitudes a la aplicación.
      # app-uno es el nombre que le dimos al servicio en docker-compose.yml
      proxy_pass http://app-uno/;
  }
}

```

> Esta configuración se aplica para cada aplicación

# Apliación html
Simplemente necesitas crear archivos HTML básicos para cada una de tus aplicaciones. Estos archivos pueden tener contenido simple que te permita distinguir si la redirección de Nginx se está realizando correctamente. Puedes nombrar estos archivos de manera descriptiva, por ejemplo, `index.html` o `welcome.html`.

Estos archivos HTML deberán colocarse en las carpetas correspondientes a cada una de tus aplicaciones, de acuerdo con la estructura de directorios que hayas definido en tu proyecto. Por ejemplo, podrían estar en las carpetas `app-uno/html` y `app-dos/html` respectivamente, como lo indican las rutas de copia en tu archivo `Dockerfile`.

# Configura tu archivo host

### Windows:

1. Abre el Bloc de notas como administrador. Puedes hacer esto haciendo clic derecho en el Bloc de notas desde el menú de inicio y seleccionando "Ejecutar como administrador".

2. En el Bloc de notas, abre el archivo hosts ubicado en `C:\Windows\System32\drivers\etc\hosts`.

3. Añade las siguientes líneas al final del archivo, reemplazando `app-uno.com` y `app-dos.com` con los nombres de tus dominios:

   ```plaintext
   127.0.0.1 app-uno.com
   127.0.0.1 app-dos.com
   ```

4. Guarda el archivo y cierra el Bloc de notas.

### Linux:

1. Abre una terminal.

2. Abre el archivo hosts con tu editor de texto preferido. Puedes utilizar nano, por ejemplo:

   ```bash
   sudo nano /etc/hosts
   ```

3. Añade las siguientes líneas al final del archivo, reemplazando `app-uno.com` y `app-dos.com` con los nombres de tus dominios:

   ```plaintext
   127.0.0.1 app-uno.com
   127.0.0.1 app-dos.com
   ```

4. Guarda los cambios y cierra el editor.

Una vez que hayas guardado estos cambios, podrás acceder a tus aplicaciones en el navegador utilizando los nombres de dominio especificados en el archivo hosts. Por ejemplo, podrías acceder a `http://app-uno.com` y `http://app-dos.com` en tu navegador y ser redirigido correctamente a tus aplicaciones.