#!/bin/sh

set -e


entrypoint_log() {
  if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
    echo "$@"
  fi
}

entrypointDir=/etc/nginx/entrypoint.d/

if [ "$1" = "nginx" ] || [ "$1" = "nginx-debug" ]; then
  if /usr/bin/find "$entrypointDir" -mindepth 1 -maxdepth 1 -type f -print -quit 2>/dev/null | read v; then
    entrypoint_log "$0: $entrypointDir is not empty, will attempt to perform configuration"

    entrypoint_log "$0: Looking for shell scripts in $entrypointDir"
    find "$entrypointDir" -follow -type f -print | sort -V | while read -r f; do
      case "$f" in
        *.envsh)
          if [ -x "$f" ]; then
            entrypoint_log "$0: Sourcing $f";
            . "$f"
          else
            # warn on shell scripts without exec bit
            entrypoint_log "$0: Ignoring $f, not executable";
          fi
          ;;
        *.sh)
          if [ -x "$f" ]; then
            entrypoint_log "$0: Launching $f";
            "$f"
          else
            # warn on shell scripts without exec bit
            entrypoint_log "$0: Ignoring $f, not executable";
          fi
          ;;
        *) entrypoint_log "$0: Ignoring $f";;
      esac
    done

    entrypoint_log "$0: Configuration complete; ready for start up"
  else
    entrypoint_log "$0: No files found in $entrypointDir, skipping configuration"
  fi
fi

exec "$@"