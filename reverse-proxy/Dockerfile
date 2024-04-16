# Definición de la imagen base para el proxy
FROM nginx:alpine3.18 as proxy

# Exponer el puerto 80 para permitir la comunicación con otras aplicaciones
EXPOSE 80

# Crear el directorio para los sitios habilitados
RUN mkdir -p /etc/nginx/sites-enabled/

# Copiar los archivos estáticos del sitio web desde el contexto de construcción al directorio de documentos raíz de Nginx en el contenedor
COPY proxy/html /usr/share/nginx/html

# Copiar los archivos de configuración de los sitios web desde los directorios app-uno y app-dos del contexto de construcción al directorio de configuración de Nginx en el contenedor
COPY app-uno/app-uno.com.conf /etc/nginx/sites-available/app-uno.com.conf
COPY app-dos/app-dos.com.conf /etc/nginx/sites-available/app-dos.com.conf

# Crear enlaces simbólicos desde los archivos de configuración en /etc/nginx/sites-available/ a /etc/nginx/sites-enabled/ para habilitar los sitios web
RUN ln -s /etc/nginx/sites-available/app-uno.com.conf /etc/nginx/sites-enabled/
RUN ln -s /etc/nginx/sites-available/app-dos.com.conf /etc/nginx/sites-enabled/

# Copiar el archivo de configuración general de Nginx desde el contexto de construcción al directorio de configuración de Nginx en el contenedor
COPY proxy/nginx.conf /etc/nginx/conf.d

# Especificar el comando de inicio del contenedor para iniciar Nginx en primer plano
CMD [ "nginx","-g","daemon off;" ]

# Definición de la imagen base para app-uno
FROM nginx:alpine3.18-slim as app-uno

# Eliminar el archivo de configuración predeterminado de Nginx para evitar conflictos con los archivos de configuración personalizados
RUN rm /etc/nginx/conf.d/default.conf

# Copiar los archivos estáticos del sitio web desde el contexto de construcción al directorio de documentos raíz de Nginx en el contenedor
COPY app-uno/html /usr/share/nginx/html/

# Copiar el archivo de configuración específico de Nginx desde el contexto de construcción al directorio de configuración de Nginx en el contenedor
COPY app-uno/nginx.conf /etc/nginx/conf.d

# Especificar el comando de inicio del contenedor para iniciar Nginx en primer plano
CMD [ "nginx","-g","daemon off;" ]

# Definición de la imagen base para app-dos
FROM nginx:alpine3.18-slim as app-dos
RUN rm /etc/nginx/conf.d/default.conf
COPY app-dos/html /usr/share/nginx/html
COPY app-dos/nginx.conf /etc/nginx/conf.d
CMD [ "nginx","-g","daemon off;" ]
