#!/bin/bash

TRIES=25
echo " ----------- Trying to connecto to Mysql ----------- " 
CAN_CONNECT=false
while [ CAN_CONNECT == "" ] && [ $TRIES -lt $TRIES ] ; do 
    sleep 1; # Wait to be sure the mysql connection is possible
    echo " ----------- Sleep 1 (wait DB) ----------- " 
    TRIES=($TRIES+1)
    CAN_CONNECT=$(mysql --connect-timeout=1 -h $MYSQL_HOST -u root -p$MYSQL_ROOT_PASSWORD -e "show databases") 
done

/usr/sbin/apache2ctl -D FOREGROUND