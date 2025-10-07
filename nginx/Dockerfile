FROM docker.io/library/nginx:1.29.1-alpine-otel AS build

# NGINX_VERSION is available from the base image
RUN --mount=type=cache,target=/var/cache/apk \
    set -eux; \
    function echoStep() { printf "\n\x1b[0;36m🔸 $1\x1b[0m\n\n"; } \
    echoStep "Install dependencies"; \
    apk add --no-cache \
        build-base \
        cmake \
        curl \
        git \
        linux-headers \
        openssl-dev \
        pcre-dev \
        zlib-dev; \
    \
    echoStep "Download NGINX source code"; \
    curl -sSL "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" | tar -xzC /tmp; \
    \
    echoStep "Cloning ngx_brotli repository"; \
    git clone --depth=1 --recurse-submodules -j8 https://github.com/google/ngx_brotli.git /tmp/ngx_brotli; \
    \
    echoStep "Build brotli"; \
    cd /tmp/ngx_brotli/deps/brotli; \
    mkdir out; \
    cd out; \
    cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=OFF \
        -DCMAKE_C_FLAGS="-Ofast -m64 -march=native -mtune=native -flto -funroll-loops -ffunction-sections -fdata-sections -Wl,--gc-sections" \
        -DCMAKE_CXX_FLAGS="-Ofast -m64 -march=native -mtune=native -flto -funroll-loops -ffunction-sections -fdata-sections -Wl,--gc-sections" \
        -DCMAKE_INSTALL_PREFIX=./installed ..; \
    cmake \
        --build . \
        --config Release \
        --target brotlienc; \
    \
    echoStep "Configure NGINX with the brotli dynamic module"; \
    cd "/tmp/nginx-${NGINX_VERSION}"; \
    ./configure \
        --with-compat \
        --add-dynamic-module=/tmp/ngx_brotli; \
    \
    echoStep "Building the dynamic modules"; \
    make modules; \
    \
    echoStep "Copying the dynamic modules to /tmp/modules"; \
    mkdir -p /tmp/modules; \
    cp -v "objs/ngx_http_brotli_filter_module.so" /tmp/modules/; \
    cp -v "objs/ngx_http_brotli_static_module.so" /tmp/modules/



# Final stage
FROM docker.io/library/nginx:1.29.1-alpine-otel

# Clean default configurations and files
RUN rm -rfv /docker-entrypoint* /etc/nginx/conf.d/* /etc/nginx/nginx.conf /var/www/html /usr/share/nginx/html /data

# Copy custom configuration files
COPY etc/nginx/ /etc/nginx/

# Copy the dynamic module from the build stage
COPY --from=build /tmp/modules/*.so /etc/nginx/modules/

RUN chmod a+rx /etc/nginx/entrypoint.sh /etc/nginx/entrypoint.d/*.sh
# RUN ls -RlAhF /etc/nginx

EXPOSE 80
STOPSIGNAL SIGQUIT
WORKDIR /data
ENTRYPOINT ["/etc/nginx/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]

# Default environment for nginx template
ENV NGINX_WORKER_CONNECTIONS=2048 \
    NGINX_PROCESSES_AUTOTUNE="on"

ARG BUILD_REV
ARG BUILD_DATE
LABEL org.opencontainers.image.title="alwatr/nginx" \
      org.opencontainers.image.description="The slim (lightweight) version of the NGINX web server, packaged by Alwatr." \
      org.opencontainers.image.base.name="docker.io/library/nginx:1.29.1-alpine-otel" \
      org.opencontainers.image.version="1.29.1" \
      org.opencontainers.image.ref.name="1.29.1-alpine-otel" \
      org.opencontainers.image.licenses="MPL-2.0" \
      org.opencontainers.image.created=${BUILD_DATE} \
      org.opencontainers.image.revision=${BUILD_REV} \
      org.opencontainers.image.vendor="Alwatr" \
      org.opencontainers.image.source="https://github.com/Alwatr/nginx" \
      org.opencontainers.image.url="https://github.com/Alwatr/nginx" \
      org.opencontainers.image.documentation="https://github.com/Alwatr/nginx" \
      org.opencontainers.image.authors="S. Ali Mihandoost <ali.mihandoost@gmail.com> (https://ali.mihandoost.com)"
