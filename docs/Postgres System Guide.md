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
cd /Users/jeff/devl/Postgres/local/etc
rm Makefile
ln -s Makefile_test Makefile
```

Shutdown the existing components:

`make sto
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


## NFS persistant storage

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

### BabyBlue

For each node in the cluster:

Create a mount point on the node for the shared NFS volume:

`sudo mkdir -p /mnt/Synology/NFS`

Add a line to /etc/fstab to mount the volume on boot:

```
cat /etc/fstab

#
#  NFS
synology.local:/volume4/BabyBlueNFS	/mnt/Synology/NFS	nfs	defaults 0 0
```

### Enki

From the deployment server:

Create the persistant volume:

```
cd prod/postgres/local/etc
kubectl apply -f volume.yaml
```







