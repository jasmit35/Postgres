# PgPods System Guide
# Development Cycle
## Startup

### Shutdown the previous version (if running)

`make dc-ps`

`make dc-stop`

`make dc-rm`

### Remove the existing storage (think first! Bye Bye data)

`make remove-volume`

### Create new persistant storage

`make create-volume`

### Build a new version of the Docker image

`make dc-build`

### Start the server container

`make dc-run`

### Check the status

`make dc-ps`

## Debugging

## Validation

`make dc-exec`

## Shutdown

### Finalizing the version in development.
Finsh the commit and pushes to the git repositories:

`git add --all`

`git commit -m ''`

`git push github master`

`git push woz master`

Upload the new image to docker hub:

`make push-image`


##  Deployment in Test & Production
Shutdown the existing components:

`make stop`

`make rm`

`docker network rm postgres-network`

`make volume-rm`

Run the update script:

`auto-update -a pgpods`

Pull the new docker image:

`docker pull jasmit/pgpods:v0.3.x`

Complete the normal auto_update steps from Fire-Starter.

Create the file pgpods/.secrets-db-data that holds the Postgres account's password. This file does not get saved to Git Hub (on purpose) and must be recreated each time.

Rebuild the network and storage componets:

`make network-create`

`make storage-create`

Relaunch the container:

`make build`

`make run`




