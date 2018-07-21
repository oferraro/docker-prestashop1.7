PRESTA_ID="presta-web"

show_img_id: ##@ View Prestashop Image ID
	@echo $(PRESTA_ID)

build:  ##@ Build the image
	docker-compose build $(TARGET)

build-nc: ##@ Build the image not using cache 
	docker-compose build --no-cache $(TARGET)

up: ##@ Start the image
	docker-compose up -d $(TARGET)

stop: ##@ Stop image
	docker stop $(PRESTA_ID)

delete: ##@ Delete image
	docker rm $(PRESTA_ID)

logs: ##@ show logs (tail)
	docker logs -t $(PRESTA_ID)

logsf: ##@ show logs in real time
	docker logs -f -t $(PRESTA_ID)

ps: ##@ Show docker processes
	docker ps

install_prestashop: ##@ Install
	@echo install Prestashop in $(PRESTA_ID)
	docker exec $(PRESTA_ID) /install-prestashop.sh

rebuild_db: ##@ Delete and create database from scratch
	@echo rebuild Prestashop DB in $(PRESTA_ID)
	docker exec $(PRESTA_ID) /rebuild-db.sh

login_bash: ##@ Log into the machine
	docker exec -it  $(PRESTA_ID) bash

reset_file_permissions: ##@ Fix file permissions in Magento folder
	docker exec -it $(PRESTA_ID) chown www-data:www-data /var/www/html/ -R
	docker exec -it $(PRESTA_ID) find /var/www/html/ -type d -exec chmod 775 {} \; 
	docker exec -it $(PRESTA_ID) find /var/www/html/ -type f -exec chmod 664 {} \; 

.DEFAULT_GOAL := help

help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?##@ "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' \
		| sed -e 's/\[32m##/[33m/'
