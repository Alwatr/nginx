#!/bin/sh

set -eu

ME=$(basename "$0")

test -z "${NGINX_ACCESS_LOG:-}" && exit 0

echo "$ME: Generate access log configuration from NGINX_ENABLE_ACCESS_LOG"

if [ "${NGINX_ENABLE_ACCESS_LOG:-0}" = "1" ]
then
  NGINX_ACCESS_LOG="/var/log/nginx/access.log json"
else
  NGINX_ACCESS_LOG="off"
fi

echo "$ME: Access log configuration is set to '$NGINX_ACCESS_LOG'"

export NGINX_ACCESS_LOG

exit 0
