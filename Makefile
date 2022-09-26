#!make
include .env
export

initialize:
	echo 'Docker compose up'
	docker-compose up -d
	docker exec -it ${APP_NAME}-app bash ./docker/configure.sh

attach-workspace:
		docker exec -it ${APP_NAME}-app  bash

test:
		docker exec -it ${APP_NAME}-app  bash -c "./vendor/bin/pint --test && php artisan dusk && php artisan test --parallel --recreate-databases --env=testing"

dusk:
		docker exec -it ${APP_NAME}-app  bash -c "php artisan test --parallel --recreate-databases --env=testing"

pint:
		docker exec -it ${APP_NAME}-app  bash -c "./vendor/bin/pint --test"
