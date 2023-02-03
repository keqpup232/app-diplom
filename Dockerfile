FROM nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY site /usr/share/nginx/html