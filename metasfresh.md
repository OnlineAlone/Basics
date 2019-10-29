backup metasfresh database using docker?
Backup Database
Run this command on your docker host to export the database from the docker container to your docker host:

docker exec -u postgres metasfreshdocker_db_1 pg_dump -Fc -d metasfresh > ./metasfresh_backup.pgdump 

Note: You can check the actual docker name using docker ps.

Exclude Big Tables in Export
Use this parameter to exclude big tables that contain data you do not want to transfer:

-T <schema>.<tablename>

Example:

docker exec -u postgres mf_db_1 pg_dump -Fc -d metasfresh -T public.ad_issue > ./metasfresh_backup.pgdump

#
cd ./metasfresh-docker
docker-compose down
tar cvzf /mybackupstorage/metasfresh.tar.gz ./
#

Backup
```
cd ./metasfresh-docker  #the directory containing the docker-compose.yml file
docker-compose down  #stop your running metasfresh-docker
tar cvzf /my/backup/location/metasfresh.tar.gz ./   #backup
docker system prune -fa   #remove docker images - you won't need them
cp -a ./docker-compose.yml ../   #copy the docker-compose.yml somewhere else so you can keep it on updating
## then follow this guide: http://docs.metasfresh.org/installation_collection/EN/How_do_I_update_metasfresh_using_Docker.html
cp -a ../docker-compose.yml ./  #put your original docker-compose.yml back in place
docker-compose up -d  #pull, build and start which will automatically apply update-scripts to the database
```
Restore
```
cd ./metasfresh-docker
docker-compose down   #stop your new metasfresh-docker version
docker system prune -fa   #remove images
rm -rf ./*  # just remove everything
cp -a tar cvzf /my/backup/location/metasfresh.tar.gz ./  #put the backup tarball back in place
tar xvzf ./metasfresh.tar.gz  #and extract it
docker-compose up -d  #pull, build and start which will automatically apply update-scripts to the database

# keep in mind all data between update and restore are lost - so you have exactly the same version as at the time you performed the backup
```
