#!/bin/sh
set -eu

# FIXME: nginx: [emerg] invalid condition "$host" in 40-force-domain.conf:1 (its work perfectly in production!)
# test -n "${TEST_MODE:-}" && exit 0
test -n "${NGINX_FORCE_DOMAIN:-}" && exit 0

ME=$(basename "$0")
echo "$ME: Remove force domain location config"
rm -fv /etc/nginx/conf.d/location.d/root.d/30-force-domain.conf

exit 0
