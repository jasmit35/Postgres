#  Docker file to create my Postgres server 
#  Start with the postgres 13 image on alpine Linux
FROM postgres:13.6

#  Environment variables that affect the base image and the db creation
ENV PGBASE=/opt/app/postgres
ENV LANG="en_US.utf8"
ENV PGDATA=$PGBASE/data/database
ENV POSTGRES_USER="postgres"
ENV POSTGRES_PASSWORD="postgres"
ENV POSTGRES_DB="postgres"
ENV POSTGRES_INITDB_ARGS="--local=en_US.utf8 --pgdata=$PGDATA --data-checksums --auth=md5 --username=postgres"

#  Copy our code into the image
USER root
WORKDIR $PGBASE 
COPY local local
RUN chown -R $POSTGRES_USER:$POSTGRES_USER $PGBASE
RUN chmod -R 777 $PGBASE
# USER ${POSTGRES_USER}

#  Expose the port the image defined
EXPOSE 5432

#  Our startup script
# ENTRYPOINT ["local/bin/docker-entrypoint.sh"]
 


#  ENV POSTGRES_INITDB_XLOGDIR="/opt/pgpods/pg_xlog/pgdb"
#  ENV PGHOME=$PGBASE/product/pgsql-12
#  ENV PGLOCAL=$PGBASE/local
#  ENV PGTABLESPACES=$PGBASE/data/tablespaces
#  ENV PGBACKUP=$PGBASE/backup
#  ENV PGLOG=$PGBASE/log
#  ENV PGXLOG=$PGBASE/pg_xlog/pgdb
#  ENV PGPROPERTIES=$PGBASE/postgres.properties
#  ENV PATH=$PATH:$PGHOME/bin:$PGLOCAL/bin

#  Update the image
# USER root
# RUN apt-get autoclean && apt-get -y update && apt-get -y upgrade
# RUN set -x \
# 	&& chown -vR postgres:postgres $PGBASE \
# 	&& chmod -vR 777 $PGBASE 
#
#  Additional software we need in the image
# RUN install -y nfs-common
