FROM nginx:alpine3.18 as principal
EXPOSE 80
RUN mkdir -p /etc/nginx/sites-enabled/
RUN chmod 777 /etc/nginx/sites-enabled
COPY paginap /usr/share/nginx/html
COPY proxy/wolfycode.com.conf /etc/nginx/sites-available/wolfycode.com.conf
COPY proxy/app-uno.com.conf /etc/nginx/sites-available/app-uno.com.conf
RUN ln -s /etc/nginx/sites-available/wolfycode.com.conf /etc/nginx/sites-enabled/
RUN ln -s /etc/nginx/sites-available/app-uno.com.conf /etc/nginx/sites-enabled/
COPY nginx/nginx.conf /etc/nginx/conf.d
CMD [ "nginx","-g","daemon off;" ]

FROM nginx:alpine3.18-slim as wolfycode
RUN rm /etc/nginx/conf.d/default.conf
COPY pagina1 /usr/share/nginx/html/p1
COPY nginx1/nginx.conf /etc/nginx/conf.d
CMD [ "nginx","-g","daemon off;" ]

FROM nginx:alpine3.18-slim as app-uno
RUN rm /etc/nginx/conf.d/default.conf
COPY pagina2 /usr/share/nginx/html/p2
COPY nginx2/nginx.conf /etc/nginx/conf.d
CMD [ "nginx","-g","daemon off;" ]