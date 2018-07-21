#!/bin/bash

cd /var/www/html/ 
echo " ----------- Delete everything at mountpoint /var/www/html ----------- "
rm -rf /var/www/html/* 

PRESTASHOP="prestashop_1.7.4.0.zip"
if [ ! -f /var/www/$PRESTASHOP ]; then
    echo " ----------- Downloading Prestashop ----------- "
    wget http://www.prestashop.com/download/releases/$PRESTASHOP -O /var/www/$PRESTASHOP> /dev/null 2>&1
fi

echo " ----------- Unzip Presthop main zip ----------- "
unzip -o /var/www/$PRESTASHOP > /dev/null 2>&1
echo " ----------- Unzip Prestashop 2nd zip ----------- " 
unzip -o /var/www/html/prestashop.zip > /dev/null 2>&1
echo " ----------- Install Prestashop ----------- " 
php /var/www/html/install/index_cli.php --domain=$PRESTA_DOMAIN:$PRESTA_PORT \
    --db_server=$MYSQL_HOST --db_name=$MYSQL_DATABASE --db_user=$MYSQL_USER \
    --db_password=$MYSQL_PASSWORD --email=$PRESTA_ADMIN_EMAIL --password=$PRESTA_ADMIN_PASSWORD 

echo " ----------- Setting Prestashop Dev Mode in config/defines.inc.php ----------- " 
sed -i "s/define('_PS_MODE_DEV_', false);/define('_PS_MODE_DEV_', true);/g" /var/www/html/config/defines.inc.php

echo " ----------- deleting install folder ----------- " 
rm -rf /var/www/html/install > /dev/null

echo " ----------- Set /var/www/html permissions ----------- " 
chown www-data:www-data /var/www/html -R
find /var/www/html -type d -exec chmod ug+rwx {} \;
find /var/www/html -type f -exec chmod ug+rw {} \;