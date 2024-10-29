#!/bin/sh
set -eu

ME=$(basename "$0")

test -n "${NGINX_AUTO_WEBP:-}" && exit 0

echo "$ME: Remove auto webp config"
rm -fv /etc/nginx/conf.d/http.d/42-map-webp.conf
rm -fv /etc/nginx/conf.d/location.d/60-webp.conf

exit 0
