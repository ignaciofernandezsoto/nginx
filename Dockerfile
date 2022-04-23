FROM nginx

COPY default /etc/nginx/sites-available/
COPY nginx.conf /etc/nginx/
