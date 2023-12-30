# Alwatr Accelerated Web Server

This is a high-performance version of NGINX, which has been enhanced by Alwatr for the purpose of serving static content efficiently.

## Usage

The recommended method for using the Alwatr Nginx is to place it behind a Kubernetes ingress or a simple edge reverse-proxy like Traefik. In this setup, there's no need to configure edge features such as gzip compression, SSL, etc., or even set up a domain or multiple websites.

```Dockerfile
FROM ghcr.io/alwatr/nginx:2
```

### Serve Progressive Web Apps

```Dockerfile
ARG NODE_VERSION=lts
ARG ALWATR_NGINX_VERSION=2
FROM docker.io/library/node:${NODE_VERSION} as builder
WORKDIR /app
COPY package.json *.lock ./
RUN if [ -f *.lock ]; then \
      yarn install --frozen-lockfile --non-interactive --production false; \
    else \
      yarn install --non-interactive --production false; \
    fi;
COPY . .
RUN yarn build

# ---

FROM ghcr.io/alwatr/nginx-pwa:${ALWATR_NGINX_VERSION} as nginx
# Config nginx
ENV NGINX_ACCESS_LOG="/var/log/nginx/access.log json"
# Copy builded files from last stage
COPY --from=builder /app/dist/ ./
RUN pwd; ls -lAhF;
```
