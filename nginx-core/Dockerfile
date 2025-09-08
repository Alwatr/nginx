FROM ghcr.io/alwatr/nginx:4.0.0

RUN apk add --no-cache curl
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --start-interval=1s --retries=3 CMD curl -fso /dev/null http://localhost/server-info || exit 1

WORKDIR /data

COPY etc/nginx/ /etc/nginx/
COPY default-data/ /default-data/
# RUN ls -RlahF /etc/nginx /default-data /data

# Default environment for nginx template
ENV NHERIT_ACCESS_LOG="" \
    NHERIT_ENABLE_ACCESS_LOG="on" \
    NHERIT_ERROR_LOG_LEVEL=notice \
    NHERIT_WORKER_CONNECTIONS=2048 \
    NHERIT_LIMIT_REQ_ERROR=503 \
    NHERIT_LIMIT_REQ_LOG=notice \
    NHERIT_AUTOINDEX=off \
    NHERIT_DOCUMENT_ROOT=/data \
    NHERIT_FORCE_DOMAIN="" \
    NHERIT_FORCE_DOMAIN_STATUS=302 \
    NHERIT_FORCE_REDIRECT_STATUS=307 \
    NHERIT_AUTO_WEBP="off" \
    NHERIT_PROCESSES_AUTOTUNE="on" \
    NHERIT_CORS_ENABLE="off" \
    NHERIT_CORS_ORIGIN="*" \
    NHERIT_CORS_METHODS="GET, OPTIONS" \
    NHERIT_CORS_HEADERS="*" \
    NHERIT_CORS_MAXAGE=86400 \
    NHERIT_RESOLVERS="local" \
    NHERIT_RESOLVER_VALID=10s

ENV NHERIT_CLIENT_MAX_BODY_SIZE=10m \
    NHERIT_SENDFILE=on \
    NHERIT_SENDFILE_MAX_CHUNK=2m \
    NHERIT_TCP_NOPUSH=on \
    NHERIT_TCP_NODELAY=on \
    NHERIT_OPEN_FILE_CACHE="max=1000 inactive=30m" \
    NHERIT_OPEN_FILE_CACHE_VALID=1s \
    NHERIT_OPEN_FILE_CACHE_MIN_USES=2 \
    NHERIT_OUTPUT_BUFFERS="8 16k" \
    NHERIT_EXPIRES_DYNAMIC=epoch \
    NHERIT_EXPIRES_STATIC=epoch \
    NHERIT_EXPIRES_DEFAULT=epoch \
    NHERIT_LIMIT_REQ_RATE=200 \
    NHERIT_LIMIT_REQ_BURST=1000 \
    NHERIT_GZIP=on \
    NHERIT_GZIP_VARY=on \
    NHERIT_GZIP_COMP_LEVEL=5 \
    NHERIT_GZIP_MIN_LENGTH=256 \
    NHERIT_DISABLE_SYMLINKS=if_not_owner

ARG BUILD_REV
ARG BUILD_DATE
LABEL org.opencontainers.image.title="alwatr/nginx-core" \
      org.opencontainers.image.description="This is a high-performance version of NGINX, which has been enhanced by Alwatr for the purpose of serving static content efficiently." \
      org.opencontainers.image.base.name="ghcr.io/alwatr/nginx:4.0.0" \
      org.opencontainers.image.version="4.0.0-nginx1.29.1" \
      org.opencontainers.image.ref.name="4.0.0-nginx1.29.1-alpine-slim" \
      org.opencontainers.image.licenses="MPL-2.0" \
      org.opencontainers.image.created=${BUILD_DATE} \
      org.opencontainers.image.revision=${BUILD_REV} \
      org.opencontainers.image.vendor="Alwatr" \
      org.opencontainers.image.source="https://github.com/Alwatr/nginx" \
      org.opencontainers.image.url="https://github.com/Alwatr/nginx" \
      org.opencontainers.image.documentation="https://github.com/Alwatr/nginx" \
      org.opencontainers.image.authors="S. Ali Mihandoost <ali.mihandoost@gmail.com> (https://ali.mihandoost.com)"
