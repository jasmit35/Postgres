# Working with Docker
### Build the image
`docker build --tag com-jasmit-pgpods/database:0.0.0 .`
### Run the image
`docker run --name pgpods-database -d com-jasmit-pgpods/database:0.0.0`
### List the running container(s)
`docker container ls`
### Connect to a running container
`docker exec -it pgpods-database /bin/bash`

### Stop the container
`docker stop pgpods-database`

###  Remove the container
`docker rm pgpods-database`

# Working with Kubernetes
### Start the pod
`kubectl apply -f ../docker/pgpods.yaml`

### Get a formated list of the pods
`kubectl get pods --all-namespaces -o=custom-columns=NameSpace:.metadata.namespace,NAME:.metadata.name,CONTAINERS:.spec.containers[*].name`

### Delete a pod
`kubectl delete pgpods-database`

# Full Test Cycle
## Startup
### Build a new version of the Docker image
`cd /Users/jeff/devl/PgPods/src/database/local/docker`

`docker build --tag com.jasmit.pgpods/database:0.0.2 .`

### Create the persistant storage
`/Users/jeff/devl/PgPods/src/storage/local/bin/pv_create`

### Use K8s to start the server pod
`kubectl apply -f '/Users/jeff/devl/PgPods/src/database/local/docker/pgpods.yaml'`

### Check the status
`kubectl get pods -o wide`

If the startup failed, perform the "Startup debugging" section.
If the pod is running, perform the "Validation" section. 

## Startup Debugging
Pods status stays "pending".

Describe the pod to see if anything appears amiss.

`kubectl describe pod pgpods-database`

## Validation
Connect into the running pod:

`kubectl exec -it pgpods-database -- /bin/bash`






## Shutdown
`kubectl delete pod pgpods-database`

Remove the persistant storage (optional)

`/Users/jeff/devl/PgPods/src/storage/local/bin/pv_remove`