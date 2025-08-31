#!/bin/sh

set -eu

ME=$(basename "$0")

test -z "${NGINX_DISALLOW_ROBOTS:-}" && exit 0

echo "$ME: Replace robots.txt to disallow all robots"
cp -afv /default-data/robots.txt $NGINX_DOCUMENT_ROOT/

exit 0
