# Indique à docker que c'est sur l'OS alpine que nous voulons faire tourner notre machine
FROM alpine:3.21.2

# Mise à jour et/ou installation d'nginx et openssl 
RUN apk update && apk add openssl nginx

# Création des dossiers nécessaires
RUN mkdir -p /var/www/wordpress /etc/nginx/ssl /run/nginx

# Génère un certificat SSL qui s'auto sign pour HTTPS
RUN openssl req -newkey rsa:2048 -nodes \
    -keyout /etc/nginx/ssl/inception.key \
    -x509 -days 365 \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=FR/L=Le Havre/O=42 Le Havre/OU=42/CN=loribeir.42.fr/UID=loribeir"

# Copie de la config personnalisé depuis le dossier "conf" vers le dossier de conf de Nginx dqns le conteneur
COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;"]