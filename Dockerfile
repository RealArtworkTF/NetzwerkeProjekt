# Test-Dockerfile, kann auch wieder gelöscht werden, wenn notwendig
FROM nginx:alpine
COPY !DOCTYPE.html /usr/share/nginx/html
