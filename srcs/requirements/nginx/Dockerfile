# Indique à docker que c'est sur l'OS alpine que nous voulons faire tourner notre machine
FROM alpine:3.21.2

# Execution des commandes : mise a jour/ajout des paquets
RUN apk update && apk add openssl nginx

#Exec des commandes suivantes : dossier pour les volumes
RUN mkdir -p /var/www/wordpress /etc/nginx/ssl /run/nginx

#Exec des 
RUN openssl req -newkey rsa:2048 -nodes \
    -keyout /etc/nginx/ssl/inception.key \
    -x509 -days 365 \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=FR/L=Le Havre/O=42 Le Havre/OU=42/CN=${DOMAIN_NAME}/UID=loribeir"
