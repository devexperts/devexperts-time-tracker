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

compose_ssl="docker-compose --profile proxy-ssl"
compose_no_ssl="docker-compose --profile proxy-no-ssl"

case $1 in
  init)
    check_env_var "FULL_CHAIN_PEM"
    check_env_var "PRIVATE_KEY_PEM"
    docker network create backend 2>/dev/null || true
    docker volume create dumps 2>/dev/null || true
    envsubst '${JTT_WEBAPP_HOST} ${FULL_CHAIN_PEM} ${PRIVATE_KEY_PEM}' < proxy/nginx.conf.template > proxy/nginx.conf
    ;;
  init-no-ssl)
    docker network create backend 2>/dev/null || true
    docker volume create dumps 2>/dev/null || true
    envsubst '${JTT_WEBAPP_HOST}' < proxy/nginx.no-ssl.conf.template > proxy/nginx.no-ssl.conf
    ;;
  start)
    $compose_ssl up -d
    ;;
  start-no-ssl)
    $compose_no_ssl up -d
    ;;
  stop)
    $compose_ssl down
    ;;
  stop-no-ssl)
    $compose_no_ssl down
    ;;
  restart)
    $compose_ssl down && $compose_ssl up -d
    ;;
  restart-no-ssl)
    $compose_no_ssl down && $compose_no_ssl up -d
    ;;
  update)
    $compose_ssl down
    $compose_ssl up -d
    ;;
  *)
    echo "Unknown parameter. Doing nothing"
    ;;
esac
