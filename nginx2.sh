#!/bin/bash
yum install wget -y
yum update -y
yum groupinstall -y 'Development Tools' && yum install -y vim
yum install -y epel-release
yum install -y perl perl-devel perl-ExtUtils-Embed libxslt libxslt-devel libxml2 libxml2-devel gd gd-devel GeoIP GeoIP-devel
curdir=$(pwd)
wget http://luajit.org/download/LuaJIT-2.1.0-beta3.tar.gz && tar xzvf LuaJIT-2.1.0-beta3.tar.gz
wget https://github.com/simplresty/ngx_devel_kit/archive/v0.3.1rc1.tar.gz && tar xzvf v0.3.1rc1.tar.gz
wget https://github.com/openresty/lua-nginx-module/archive/v0.10.13.tar.gz && tar xzvf v0.10.13.tar.gz
wget http://nginx.org/download/nginx-1.14.0.tar.gz && tar xzvf nginx-1.14.0.tar.gz
wget https://ftp.pcre.org/pub/pcre/pcre-8.40.tar.gz && tar xzvf pcre-8.40.tar.gz
wget https://www.zlib.net/zlib-1.2.11.tar.gz && tar xzvf zlib-1.2.11.tar.gz
wget https://www.openssl.org/source/openssl-1.1.0f.tar.gz && tar xzvf openssl-1.1.0f.tar.gz
rm -rf *.tar.gz
cd LuaJIT-2.1.0-beta3
make install
ln -sf luajit-2.1.0-beta3 /usr/local/bin/luajit
export LUAJIT_LIB=/usr/local/lib/
export LUAJIT_INC=/usr/local/include/luajit-2.1/
cd $curdir/nginx-1.14.0/
./configure --prefix=/opt/nginx \
         --with-ld-opt="-Wl,-rpath,$LUAJIT_LIB" \
         --add-module=$curdir/ngx_devel_kit-0.3.1rc1 \
         --add-module=$curdir/lua-nginx-module-0.10.13 \
         --with-pcre=$curdir/pcre-8.40 \
         --with-pcre-jit \
         --with-zlib=$curdir/zlib-1.2.11 \
         --with-openssl=$curdir/openssl-1.1.0f \
         --with-openssl-opt=no-nextprotoneg \
         --with-http_ssl_module
make
make install
touch /opt/nginx/conf/nginx.conf
echo "[Unit]
Description=OpsWorks test
After=syslog.target network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
PIDFile=/opt/nginx/logs/nginx.pid
ExecStartPre=/opt/nginx/sbin/nginx -t
ExecStart=/opt/nginx/sbin/nginx
ExecReload=/opt/nginx/sbin/nginx -s reload
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target" > /lib/systemd/system/nginx.service
#systemctl start nginx.service
#systemctl daemon-reload
