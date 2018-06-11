FROM ubuntu:16.04

MAINTAINER uhsder@gmail.com

ENV LUAJIT_VER=2.1.0-beta3 \
    NGXDEVEL_VER=0.3.1rc1 \
    LUANGX_VER=0.10.13 \
    NGX_VER=1.14.0 \
    PCRE_VER=8.40 \
    ZLIB_VER=1.2.11 \
    OPENSSL_VER=1.1.0f \
    NGINX_USER=www-data \
    NGINX_SITECONF_DIR=/etc/nginx/sites-enabled \
    NGINX_LOG_DIR=/var/log/nginx \
    NGINX_TEMP_DIR=/var/lib/nginx \
    NGINX_SETUP_DIR=/var/cache/nginx

RUN apt-get update
RUN apt-get install -y wget 
RUN wget https://raw.githubusercontent.com/uhsder/test/uhsder-patch-1/nginx2.sh
RUN chmod +x nginx2.sh
RUN /bin/bash -c './nginx2.sh'

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh


EXPOSE 80/tcp 443/tcp
VOLUME ["${NGINX_SITECONF_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["/usr/sbin/nginx"]
