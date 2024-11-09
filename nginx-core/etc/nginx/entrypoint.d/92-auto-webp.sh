#!/bin/sh
set -eu

test -n "${TEST_MODE:-}" && exit 0
test -n "${NGINX_AUTO_WEBP:-}" && exit 0

ME=$(basename "$0")
echo "$ME: Remove auto webp config"
rm -fv /etc/nginx/conf.d/http.d/42-map-webp.conf
rm -fv /etc/nginx/conf.d/location.d/50-webp.conf

exit 0
