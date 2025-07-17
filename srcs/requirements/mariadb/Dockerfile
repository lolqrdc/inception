FROM alpine:3.21.2

RUN apk update && apk add --no-cache mariadb-client gettext-envsubst

RUN mkdir -p /var/lib/mysql /run/mysqld && \
    chown -R mysql:mysql /run/mysqld && \
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

# Ajout de la configuration, des scripts et l'initialisation SQL
COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf 
COPY tools/init.sql /tools/init.sql
COPY tools/script.sh /tools/script.sh

USER mysql

# Lancement du script d'initilisation et ensuite démarre Mariadb
CMD ["/tools/script.sh"]
