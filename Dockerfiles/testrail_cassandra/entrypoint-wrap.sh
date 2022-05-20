#!/bin/bash

if [[ ! -z "$CASSANDRA_KEYSPACE" && $1 = 'cassandra' ]]; then
  # Create default keyspace for single node cluster
  CQL="CREATE KEYSPACE $CASSANDRA_KEYSPACE WITH REPLICATION = {'class': 'SimpleStrategy', 'replication_factor': 1};"
  until echo $CQL | cqlsh; do
    echo "cqlsh: Cassandra is unavailable - retry later"
    sleep 2
  done &
fi

if [[ ! -z "$CASSANDRA_KEYSPACE" && $1 = 'cassandra' ]]; then
  # Create default keyspace for single node cluster
  CQL="CREATE ROLE $CASSANDRA_USER with SUPERUSER = true AND LOGIN = true and PASSWORD = '$CASSANDRA_PASSWORD';"
  until echo $CQL | cqlsh; do
    echo "cqlsh: Cassandra is unavailable - retry later"
    sleep 2
  done &
fi

exec /docker-entrypoint.sh "$@"
