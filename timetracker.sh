#!/bin/bash

# Copyright (C) 2024 Devexperts Solutions IE Limited
# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

check_env_var() {
    if [ -z "${!1}" ]; then
        echo "Error: $1 is not set in the .env file."
        exit 1
    fi
}

if [ -f .env ]; then
    set -a
    source .env
    set +a
else
    echo ".env file not found."
    exit 1
fi

check_env_var "VERSION_NUMBER"
check_env_var "OAUTH_CONSUMER_KEY"
check_env_var "OAUTH_ACCESS_TOKEN"
check_env_var "OAUTH_PRIVATE_KEY"
check_env_var "OAUTH_SECRET"
check_env_var "JIRA_URL"
check_env_var "JTT_WEBAPP_HOST"
check_env_var "DH_PEM"
check_env_var "FULL_CHAIN_PEM"
check_env_var "PRIVATE_KEY_PEM"

docker_login() {
    if [ -n "${DOCKER_USERNAME}" ] && [ -n "${DOCKER_PASSWORD}" ]; then
        echo "Logging in to Docker registry..."
        docker login nexus-docker-time-tracking.in.devexperts.com -u "${DOCKER_USERNAME}" -p "${DOCKER_PASSWORD}"
    else
        echo "Docker credentials not set. Skipping docker login."
    fi
}

case $1 in
  init)
    docker_login
    docker volume create backend
    docker volume create dumps
    envsubst '${JTT_WEBAPP_HOST} ${FULL_CHAIN_PEM} ${PRIVATE_KEY_PEM} ${DH_PEM}' < jtt-proxy/nginx.conf.template > jtt-proxy/nginx.conf
    ;;
  start)
    docker-compose up -d
    ;;
  stop)
    docker-compose down
    ;;
  restart)
    docker-compose down && docker-compose up -d
    ;;
  update)
    docker-compose down
    docker_login
    docker-compose up -d
    ;;
  *)
    echo "Unknown parameter. Doing nothing"
    ;;
esac
