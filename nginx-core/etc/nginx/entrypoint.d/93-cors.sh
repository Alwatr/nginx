#!/bin/sh
set -eu

ME=$(basename "$0")

test -n "${NGINX_CORS_ENABLE:-}" && exit 0

echo "$ME: Remove CORS config"
rm -fv /etc/nginx/conf.d/location.d/70-cors.conf

exit 0
