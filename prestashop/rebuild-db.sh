#!/bin/bash

cd /var/www/html/ 
echo " ----------- Drop database if already exits ----------- " 
DB_SHOW=$(/usr/bin/mysql -h $MYSQL_HOST -u root -p$MYSQL_ROOT_PASSWORD -e "show databases" | grep $MYSQL_DATABASE); 
if [ "$DB_SHOW" != '' ]; then # DATABASE exists, DROP IT
    /usr/bin/mysql -h $MYSQL_HOST -u root -p$MYSQL_ROOT_PASSWORD -e "DROP DATABASE $MYSQL_DATABASE"
fi
echo " ----------- Create database and user/permissions again ----------- " 
# Create database again
/usr/bin/mysql -h $MYSQL_HOST -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE $MYSQL_DATABASE"
/usr/bin/mysql -h $MYSQL_HOST -u root -p$MYSQL_ROOT_PASSWORD  -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO $MYSQL_USER@'%' IDENTIFIED BY '$MYSQL_PASSWORD'"

