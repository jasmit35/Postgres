#
#  Makefile
#

OLD_VERSION := "v0.3.5"
NEW_VERSION := "v0.3.6"

################################################################################

.PHONY: create-image push-image remove-image list-image


create-image:
	docker build .
	docker tag postgres_server:latest jasmit/postgres-server:${NEW_VERSION}

push:
	docker push jasmit/postgres-server:${NEW_VERSION}

delete-image:
	docker image rm jasmit/postgres-server:${OLD_VERSION}

list:
	docker images | grep postgres


################################################################################
