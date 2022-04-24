#
#  Makefile
#

NEW_VERSION := "v0.3.5"

.PHONY: create-volume delete-volume create-network delete-network \
  create-image run-image list-image stop-image remove-image push-image

################################################################################

create-volume:
	docker volume create --name=postgres-data
	docker volume ls

delete-volume:
	docker volume rm postgres-data
	docker volume ls


################################################################################

create-network:
	docker network create postgres-network
	docker network ls

delete-network:
	docker network rm postgres-network
	docker network rm postgres_postgres-network
	docker network ls


################################################################################

create-image:
	docker-compose build
	docker tag postgres_server:latest jasmit/postgres-server:${NEW_VERSION}

run-image:
	docker-compose up -d
	docker-compose ps 

list-images:
	docker images | grep postgres

stop-image:
	docker-compose stop server
	docker-compose ps 

delete-image:
	docker image rm jasmit/postgres-server:${NEW_VERSION}
	docker-compose ps 

push-image:
	docker push jasmit/postgres-server:${NEW_VERSION}


################################################################################

ps:
	docker-compose ps 

exec:
	docker-compose exec -it server /bin/bash

logs:
	docker-compose logs server 


################################################################################

clean: stop-image remove-image

clean-all: stop-image remove-image delete-volume delete-network
	
################################################################################





################################################################################
