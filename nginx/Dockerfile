FROM docker.io/library/nginx:1.27.4-alpine-slim

RUN rm -rfv /docker-entrypoint* /etc/nginx/conf.d/* /etc/nginx/nginx.conf /var/www/html /usr/share/nginx/html /data
COPY etc/nginx/ /etc/nginx/
RUN chmod a+rx /etc/nginx/entrypoint.sh /etc/nginx/entrypoint.d/*.sh
# RUN ls -RlAhF /etc/nginx

EXPOSE 80
STOPSIGNAL SIGQUIT
WORKDIR /data
ENTRYPOINT ["/etc/nginx/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]

# Default environment for nginx template
ENV NGINX_WORKER_CONNECTIONS=2048 \
    NGINX_ENTRYPOINT_WORKER_PROCESSES_AUTOTUNE=1 \
    NGINX_ENTRYPOINT_QUIET_LOGS=""

ARG BUILD_REV
ARG BUILD_DATE
LABEL org.opencontainers.image.title="alwatr/nginx" \
      org.opencontainers.image.description="The slim (lightweight) version of the NGINX web server, packaged by Alwatr." \
      org.opencontainers.image.base.name="docker.io/library/nginx:1.27.4-alpine-slim" \
      org.opencontainers.image.version="1.27.4" \
      org.opencontainers.image.ref.name="1.27.4-alpine-slim" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.created=${BUILD_DATE} \
      org.opencontainers.image.revision=${BUILD_REV} \
      org.opencontainers.image.vendor="Alwatr" \
      org.opencontainers.image.source="https://github.com/Alwatr/nginx" \
      org.opencontainers.image.url="https://github.com/Alwatr/nginx" \
      org.opencontainers.image.documentation="https://github.com/Alwatr/nginx" \
      org.opencontainers.image.authors="S. Ali Mihandoost <ali.mihandoost@gmail.com> (https://ali.mihandoost.com)"
