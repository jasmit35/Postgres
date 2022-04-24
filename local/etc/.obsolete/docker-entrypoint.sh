#!/usr/bin/env bash
set -eo pipefail

#  Set up enough to start logging this script 
export LOGDIR=$PGBASE/local/log
export LOGRPT=$LOGDIR/init_$(date +%y_%m_%d_%H_%M_%S).log
if [ ! -d $LOGDIR ]; then
    mkdir -p $LOGDIR
fi
touch $LOGRPT
chown postgres.postgres $LOGRPT
chmod 666 $LOGRPT
exec >$LOGRPT 2>&1

echo "---  entry_start_$(id -u)  ----------------------------------------"

#  If the command starts with an option, prepend "postgres"
if [ "${1:0:1}" = '-' ]; then
	set -- postgres "$@"
fi

if [ "$1" = 'postgres' ] && [ "$(id -u)" = '0' ]; then
    #  Startup as root 
    echo "---  entry_root_sub_start  ----------------------------------------"

    #  Use 1st.run to do the things to the persistent items 
    #  that only need done once
#    if [ ! -f $PGPROPERTIES ]; then
#        /docker-entrypoint-initdb.d/1st.run
#    fi

    #  Set up /var/run
    mkdir -p /var/run/postgresql
    chown -R postgres /var/run/postgresql
    chmod 775 /var/run/postgresql

    echo "---  entry_root_sub_end  ----------------------------------------"

    #  Restart this same script using the postgres user id
    exec gosu postgres "$BASH_SOURCE" "$@"
fi


if [ "$1" = 'postgres' ]; then
    #  Startup as Postgres
    echo "---  entry_pg_sub_start  ----------------------------------------"

    #  Do the things to the persistent items that only need done once
#    if [ ! -f $PGPROPERTIES ]; then
#       /docker-entrypoint-initdb.d/1st.run
#    fi

    echo "---  entry_pg_sub_end  ----------------------------------------"
fi

echo "entry_end_$(id -u)" 

exec "$@"
