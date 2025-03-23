#!/bin/sh
if [ "$(basename $(realpath .))" != "learn-postgres" ]; then
    echo "You are outside the scope of the project"
    exit 0
fi

export PGADMIN_DEFAULT_EMAIL=admin@psql.email
export PGADMIN_DEFAULT_PASSWORD=admin

export POSTGRES_USER=postgres
export POSTGRES_PASSWORD=postgres

export PSQL_VER=17.3-alpine3.20
export PGADMIN_VER=9.0.0

export NETWORK=learn-postgress_psql

COMMAND="$1"
SUBCOMMAND="$2"

function compose(){
    local cmd=$1
    case $cmd in
        "start")
            docker compose -f ./deployments/compose/single/docker-compose.yaml up
            ;;
        "stop")
            docker compose -f ./deployments/compose/single/docker-compose.yaml down
            ;;
        *)
            echo "Usage $0 compose [start|stop]"
            ;;
    esac
}

case $COMMAND in
    "compose")
        compose $SUBCOMMAND
        ;;
    *)
        echo "Usage: $0 [compose]"
        ;;
esac