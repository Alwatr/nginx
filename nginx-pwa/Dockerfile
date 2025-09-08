FROM ghcr.io/alwatr/nginx-core:4.0.0

COPY etc/nginx/ /etc/nginx/
# COPY default-data/ /default-data/
# RUN ls -RlahF /etc/nginx /default-data /data

# Default environment for nginx template
ENV NHERIT_CLIENT_MAX_BODY_SIZE=1k \
    NHERIT_SENDFILE=on \
    NHERIT_SENDFILE_MAX_CHUNK=2m \
    NHERIT_TCP_NOPUSH=on \
    NHERIT_TCP_NODELAY=on \
    NHERIT_OPEN_FILE_CACHE="max=1000 inactive=1h" \
    NHERIT_OPEN_FILE_CACHE_VALID=1M \
    NHERIT_OPEN_FILE_CACHE_MIN_USES=2 \
    NHERIT_OUTPUT_BUFFERS="8 16k" \
    NHERIT_EXPIRES_DYNAMIC=epoch \
    NHERIT_EXPIRES_STATIC=max \
    NHERIT_EXPIRES_DEFAULT=epoch \
    NHERIT_LIMIT_REQ_RATE=400 \
    NHERIT_LIMIT_REQ_BURST=1000 \
    NHERIT_GZIP=on \
    NHERIT_GZIP_VARY=on \
    NHERIT_GZIP_COMP_LEVEL=5 \
    NHERIT_GZIP_MIN_LENGTH=256 \
    NHERIT_DISABLE_SYMLINKS=if_not_owner \
    NHERIT_CONFIG_JS_URI=

ARG BUILD_REV
ARG BUILD_DATE
LABEL org.opencontainers.image.title="alwatr/nginx-pwa" \
      org.opencontainers.image.description="This is a high-performance version of NGINX, which has been enhanced by Alwatr for the purpose of serving PWA efficiently." \
      org.opencontainers.image.base.name="ghcr.io/alwatr/nginx-core:4.0.0" \
      org.opencontainers.image.version="4.0.0" \
      org.opencontainers.image.ref.name="4.0.0-nginx1.29.1-alpine-slim" \
      org.opencontainers.image.licenses="MPL-2.0" \
      org.opencontainers.image.created=${BUILD_DATE} \
      org.opencontainers.image.revision=${BUILD_REV} \
      org.opencontainers.image.vendor="Alwatr" \
      org.opencontainers.image.source="https://github.com/Alwatr/nginx" \
      org.opencontainers.image.url="https://github.com/Alwatr/nginx" \
      org.opencontainers.image.documentation="https://github.com/Alwatr/nginx" \
      org.opencontainers.image.authors="S. Ali Mihandoost <ali.mihandoost@gmail.com> (https://ali.mihandoost.com)"
