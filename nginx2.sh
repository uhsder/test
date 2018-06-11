#!/bin/bash
apt-get update
apt-get install -y build-essential 
apt-get install -y wget vim perl perl-devel perl-ExtUtils-Embed libxslt libxslt-devel libxml2 libxml2-devel gd gd-devel GeoIP GeoIP-devel make gcc g++ --no-install-recommends
curdir=$(pwd)
wget http://luajit.org/download/LuaJIT-${LUAJIT_VER}.tar.gz
wget https://github.com/simplresty/ngx_devel_kit/archive/v${NGXDEVEL_VER}.tar.gz
wget https://github.com/openresty/lua-nginx-module/archive/v${LUANGX_VER}.tar.gz
wget http://nginx.org/download/nginx-${NGX_VER}.tar.gz
wget https://ftp.pcre.org/pub/pcre/pcre-${PCRE_VER}.tar.gz
wget https://www.zlib.net/zlib-${ZLIB_VER}.tar.gz
wget https://www.openssl.org/source/openssl-${OPENSSL_VER}.tar.gz
for a in $(ls -1 *.tar.gz); do tar -zxvf $a; done
rm -rf *.tar.gz
cd LuaJIT-${LUAJIT_VER}
make install
ln -sf luajit-${LUAJIT_VER} /usr/local/bin/luajit
export LUAJIT_LIB=/usr/local/lib/
export LUAJIT_INC=/usr/local/include/luajit-2.1/
cd $curdir/nginx-${NGX_VER}/
./configure --prefix=/usr/share/nginx \
         --conf-path=/etc/nginx/nginx.conf \
         --sbin-path=/usr/sbin \
         --http-log-path=/var/log/nginx/access.log \
         --error-log-path=/var/log/nginx/error.log \
         --lock-path=/var/lock/nginx.lock \
         --pid-path=/run/nginx.pid \
         --with-ld-opt="-Wl,-rpath,$LUAJIT_LIB" \
         --add-module=$curdir/ngx_devel_kit-${NGXDEVEL_VER} \
         --add-module=$curdir/lua-nginx-module-${LUANGX_VER} \
         --with-pcre=$curdir/pcre-${PCRE_VER} \
         --with-pcre-jit \
         --with-zlib=$curdir/zlib-${ZLIB_VER} \
         --with-openssl=$curdir/openssl-${OPENSSL_VER} \
         --with-openssl-opt=no-nextprotoneg \
         --with-http_ssl_module
make && make install
echo "[Unit]
Description=OpsWorks test
After=syslog.target network.target remote-fs.target nss-lookup.target
[Service]
Type=forking
PIDFile=/run/nginx.pid
ExecStartPre=/usr/sbin/nginx -t
ExecStart=/usr/sbin/nginx
ExecReload=/usr/sbin/nginx -s reload
ExecStop=/bin/kill -s QUIT
PrivateTmp=true
[Install]
WantedBy=multi-user.target" > /lib/systemd/system/nginx.service
rm -rf /var/lib/apt/lists/*
rm -rf $curdir/LuaJIT-${LUAJIT_VER}
rm -rf $curdir/ngx_devel_kit-${NGXDEVEL_VER}
rm -rf $curdir/pcre-${PCRE_VER}
rm -rf $curdir/lua-nginx-module-${LUANGX_VER}
rm -rf $curdir/pcre-${PCRE_VER}
rm -rf $curdir/openssl-${OPENSSL_VER}
rm -rf $curdir/nginx-${NGX_VER}
rm -rf $curdir/zlib-${ZLIB_VER}
apt-get remove -y wget vim make gcc g++
apt autoremove -y fakeroot g++-5 libalgorithm-diff-perl libalgorithm-diff-xs-perl libalgorithm-merge-perl libfakeroot libpython3.5 libstdc++-5-dev
