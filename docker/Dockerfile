FROM mariadb:latest

ENV MYSQL_DATABASE=mydb
ENV MYSQL_USER=myuser
ENV MYSQL_PASSWORD=mypassword
ENV MYSQL_ROOT_PASSWORD=rootpassword

COPY my.cnf /etc/mysql/my.cnf
COPY sql/initDB.sql /docker-entrypoint-initdb.d/

EXPOSE 5040
