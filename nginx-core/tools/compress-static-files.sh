#!/bin/sh

set -eu

echoColor() {
  # 1: red, 2: green, 3: yellow, 4: blue, 5: purple, 6: cyan, 7: light gray
  printf "\x1b[0;3$1m$2\x1b[0m"
}

echoStep() {
  echoColor 6 "\n🔸 $1\n\n"
}

echoDone() {
  echoColor 2 "\n✅ ${1:-'Done ;)'}\n\n"
}

echoError() {
  echoColor 1 "❌ ${1:-'Error :('}\n\n"
}

# Compress all files in NGINX_DOCUMENT_ROOT recursively with Brotli
# for use with nginx brotli_static module

if [ -z "${NGINX_DOCUMENT_ROOT:-}" ]; then
  echoError "Error: NGINX_DOCUMENT_ROOT environment variable is not set"
  exit 1
fi

if [ ! -d "$NGINX_DOCUMENT_ROOT" ]; then
  echoError "Error: Directory $NGINX_DOCUMENT_ROOT does not exist"
  exit 1
fi

if ! command -v brotli >/dev/null 2>&1; then
  echoStep "Installing brotli..."
  apk add --no-cache brotli
fi

echoStep "Compressing files in $NGINX_DOCUMENT_ROOT with Brotli..."

# Find and compress text-based files
# Skip already compressed files (.br, .gz, etc.)
find "$NGINX_DOCUMENT_ROOT" -type f \
  \( -name "*.html" -o -name "*.css" -o -name "*.js" \
  -o -name "*.json" -o -name "*.xml" -o -name "*.svg" \
  -o -name "*.csv" -o -name "*.yml" -o -name "*.yaml" \
  -o -name "*.txt" -o -name "*.md" -o -name "*.wasm" \
  -o -name "*.woff" -o -name "*.ttf" -o -name "*.otf" -o -name "*.eot" \
  -o -name "*.rss" -o -name "*.atom" \) \
  ! -name "*.br" ! -name "*.gz" |
  while read -r file; do
		echoStep "Compressing: $file"
		brotli --best --squash --verbose --lgwin=0 --keep --suffix=.br --force "$file"
  done

echoDone "Compression complete!"

echoColor 3 "To serve pre-compressed files, ensure \$NGINX_BROTLI_STATIC is set to 'on' (currently set to '${NGINX_BROTLI_STATIC:-off}')."
