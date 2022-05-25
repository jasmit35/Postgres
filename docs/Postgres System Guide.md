# Postgres System Guide

## Development Cycle

### Shutdown exisitng components

Make sure the "Makefile" soft link is pointing to the development version of the make file.

Use the make file to list any running components of the existing system. Use the makefile to delete them individually. Be sure to consider if you want to delete the volume component because that means losing all existing data in the database.

```
cd ~/devl/postgres/local/etc
make ps
make delete-xxx
```

### Here is where the magic happens!

Work on a small subset of the defects and enhancements for each development cycle.

### Create the new version

Edit the Makefile to correctly set the OLD_VERSION and NEW_VERSION for the image.
```
make create-all
make dc-ps
```

### Testing and Debugging


### Commit enhancements

Finsh the commit and pushes to the git repositories:

```
git add --all
git commit -m 'message'
git push github master
```

### Continue enhancements or move on

If thier are more items you wish to complete on the defects and enhancements document, then go back to the "Shutdown existing components" section. If not, upload the new image to docker hub and moving on to test deployment.

`make push-image`

##  Deployment in Test
Perform the standard update process:

```
cd ~/test
auto-update -a postgres -e test
```

Switch to the configuration directory and change to the test config:

```
cd /Users/jeff/test/Postgres/local/etc
ln -s Makefile_test Makefile
```

Determine if any existing components are running and if so, shut them down:

```
make ps
```

Pull the new docker image: (not sure this is necessary)

```
docker pull jasmit/postgres-server:v0.3.x
```

Use the Makefile to build it all, then check the results:

```
make build-all
make ps
make logs
```

##  Deployment in Production
If this is the first time for production deployment, you need to complete the steps in Appendix A to set up the NFS storage.



Perform the standard update process:

```
cd ~/prod
auto-update -a Postgres -e prod
```

Switch to the configuration directory and change to the prod config:

```
cd /Users/jeff/prod/Postgres/local/etc
ln -s Makefile_prod Makefile
```

Determine if any existing components are running and if so, shut them down:

```
make ps
```

Pull the new docker image: (not sure this is necessary)

```
docker pull jasmit/postgres-server:v0.3.x
```

Use the Makefile to build it all, then check the results:

```
make build-all
make ps
make logs
```


## Appendix A: NFS persistant storage

### Synology

Use the Synology server to set up a network file systme that will be used to store the data from the production postgres database.

Use the Synology GUI to create a new file system. This time I used 32 gig with the name "BabyBlueNFS". 

Use vi to manual change the export options for the file system as follows:

```
ssh -p 2222 jeff@synology.local
sudo vi ...

sudo cat /etc/exports
#
#  Storage on the BabyBlue cluster for production Postgres data
#
/volume4/BabyBlueNFS	192.168.1.0/24(rw,sync,no_subtree_check,no_root_squash,anonuid=999,anongid=999)
```
### Enki
Be sure to point kubectl to the prod system:

```
kcgo prod
kcpcc
```

From the deployment server, use the make command to see what components are running. Shut down those necessary:

```
cd prod/postgres/local/etc
make ps
make delete-xxx
```
Use the makefile to recreate the necessary components:

```
make create-namespace
make create-network
make create-volume
make create-statefulset
make create-service
```









