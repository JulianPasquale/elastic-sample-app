#!/bin/bash
set -e

if [ -f /app/tmp/pids/server.pid ]; then
  rm /app/tmp/pids/server.pid
fi

if [[ -z $REQUEST_TIMEOUT ]]; then
  REQUEST_TIMEOUT=60
fi

if [[ $MIGRATE = "true" ]]; then
  bundle exec rails db:create db:migrate
fi

if [[ $SEED = "true" ]]; then
  bundle exec rails db:seed
fi

exec "$@"
