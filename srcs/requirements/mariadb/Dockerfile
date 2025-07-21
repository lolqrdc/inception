FROM alpine:3.21.2

RUN apk update && apk add --no-cache mariadb mariadb-client gettext

RUN mkdir -p /var/lib/mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

# Ajout de la configuration, des scripts et l'initialisation SQL
COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf 
COPY tools/init.sql /tools/init.sql
COPY tools/script.sh /tools/script.sh
RUN chmod +x /tools/script.sh

USER mysql

# Lancement du script d'initilisation et ensuite démarre Mariadb
CMD ["/tools/script.sh"]
