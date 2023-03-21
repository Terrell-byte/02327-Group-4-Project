FROM mariadb:latest

ENV MYSQL_DATABASE=mydb
ENV MYSQL_USER=myuser
ENV MYSQL_PASSWORD=mypassword
ENV MYSQL_ROOT_PASSWORD=rootpassword

COPY my.cnf /etc/mysql/my.cnf


# Copy SQL scripts
COPY 01-createTable.sql /docker-entrypoint-initdb.d/

EXPOSE 5140


