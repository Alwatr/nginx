#!/bin/sh
set -eu

ME=$(basename "$0")


case "${NGINX_FORCE_DOMAIN:-}" in
  1|true|yes|Yes|on|ON|True|TRUE)
    echo "$ME: Enable force domain config to '$NGINX_FORCE_DOMAIN'"
    # keep the file
    ;;
  *)
    echo "$ME: Remove force domain location config"
    rm -fv /etc/nginx/conf.d/location.d/root.d/30-force-domain.conf
    ;;
esac

exit 0
