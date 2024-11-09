#!/bin/sh
set -eu

test -n "${TEST_MODE:-}" && exit 0
test -n "${NGINX_CORS_ENABLE:-}" && exit 0

ME=$(basename "$0")
echo "$ME: Remove CORS config"
rm -fv /etc/nginx/conf.d/location.d/root.d/10-cors.conf

exit 0
