#!/bin/sh

set -eu

# Set quality from the first argument, or default to 82
WEBP_QUALITY=${1:-78};

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

# Compress all images in NGINX_DOCUMENT_ROOT recursively to WebP
# for use with nginx auto-webp feature

if [ -z "${NGINX_DOCUMENT_ROOT:-}" ]; then
  echoError "Error: NGINX_DOCUMENT_ROOT environment variable is not set"
  exit 1
fi

if [ ! -d "$NGINX_DOCUMENT_ROOT" ]; then
  echoError "Error: Directory $NGINX_DOCUMENT_ROOT does not exist"
  exit 1
fi

if ! command -v cwebp >/dev/null 2>&1; then
  echoStep "Installing libwebp..."
  apk add --no-cache libwebp-tools
fi

echoStep "Compressing images in $NGINX_DOCUMENT_ROOT with WebP..."

# Find and compress image files.
# The loop below handles skipping already compressed files.
find "$NGINX_DOCUMENT_ROOT" -type f \
  \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \
  -o -name "*.gif" -o -name "*.tiff" -o -name "*.tif" \) \
  ! -name "*.webp" |
  while read -r file; do
		echoStep "Compressing: $file"
		cwebp -mt -m 6 -af -v -q "$WEBP_QUALITY" -v "$file" -o "${file}.webp"
  done

echoDone "Compression complete!"

echoColor 3 "To serve pre-compressed files, ensure \$NGINX_AUTO_WEBP is set to 'on' (currently set to '${NGINX_AUTO_WEBP:-off}')."
