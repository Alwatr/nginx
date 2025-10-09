#!/bin/sh

set -eu

ME=$(basename "$0");

entrypointDir=/etc/nginx/entrypoint.d/

if [ "$1" = "nginx" ] || [ "$1" = "nginx-debug" ]
then
  if /usr/bin/find "$entrypointDir" -mindepth 1 -maxdepth 1 -type f -print -quit 2>/dev/null | read v;
  then
    echo "$ME: $entrypointDir is not empty, will attempt to perform configuration"

    echo "$ME: Looking for shell scripts in $entrypointDir"
    find "$entrypointDir" -follow -type f -print | sort -V | while read -r f;
    do
      case "$f" in
        *.envsh)
          echo "$ME: Sourcing $f";
          . "$f"
          ;;
        *.sh)
          if [ -x "$f" ];
          then
            echo "$ME: Launching $f";
            "$f"
          else
            # warn on shell scripts without exec bit
            echo "$ME: Ignoring $f, not executable!";
          fi
          ;;
        *) echo "$ME: Ignoring $f";;
      esac
    done

    echo "$ME: Configuration complete; ready for start up"
  else
    echo "$ME: No files found in $entrypointDir, skipping configuration"
  fi
fi

exec "$@"
