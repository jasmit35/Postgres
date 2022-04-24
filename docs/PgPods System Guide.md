# PgPods System Guide
## Development Cycle

### Create persistant storage and network (one time only)

```
make create-volume
make create-network
```

### Build a new version of the Docker image

Check the yaml file to insure the correct value for VERSION.

`make build-image`

### Start the server container

`make dc-run`

### Check the status

`make dc-ps`

### Debugging

### Validation

### Shutdown

### Finalizing the version in development.

## Deployment in test

Complete the normal git commit and auto_update steps from Fire-Starter.

Create the file pgpods/.secrets-db-data that holds the Postgres account's password. This file does not get saved to Git Hub (on purpose) and must be recreated each time.

Edit pgpods/Makefile to insure the corrrect environment is being set.

# Rancher Desktop

## Set up the devlopment environment with Rancher Desktop

Verify the Rancher Desktop GUI is running. If not, start it.

`cd ~/devl/PgPods`

Edit pgpods/Makefile to insure the corrrect environment is being set.

Creat the network:

`make create-network`

`docker network ls`

Create the persistant storage

`make create-volume`

`docker volume ls`

Build the new docker image:

`make dc-build`

`docker image ls`

Start the server container

`make dc-run`

## Shut down the devlopment environment with Rancher Desktop

`cd ~/devl/PgPods`

Check to see if the container is running:

`make dc-ps`

If it is running proceed, othewise skip to the next step.

Stop the container and remove it:

`make dc-stop`

`make dc-rm`







