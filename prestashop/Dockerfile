FROM debian

LABEL maintainer="oferraro@getfinancing.com"

RUN apt-get update; apt-get -y install apache2 mysql-client \ 
    php php-mysql unzip php-xml php-zip php-curl php-gd wget

RUN a2enmod rewrite

WORKDIR /var/www/html/

COPY install-prestashop.sh /
COPY entrypoint.sh /
COPY rebuild-db.sh /
COPY prestashop.conf /etc/apache2/sites-enabled/

RUN mkdir app && chmod u+x /entrypoint.sh /install-prestashop.sh /rebuild-db.sh && \
    rm /etc/apache2/sites-enabled/000-default.conf 

EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
