#!/bin/sh
set -eu

ME=$(basename "$0")

test -n "${NGINX_FORCE_DOMAIN:-}" && exit 0

echo "$ME: Remove force domain location config"
rm -fv /etc/nginx/conf.d/location.d/40-force-domain.conf

exit 0
