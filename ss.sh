# Installation of basic build dependencies
## CentOS / Fedora / RHEL
yum update -y nss curl libcurl
yum install -y gettext gcc autoconf libtool automake make asciidoc xmlto c-ares-devel libev-devel zlib-devel pcre-devel wget net-tools rng-tools git

# Installation of libsodium
export LIBSODIUM_VER=1.0.16
wget https://github.com/hntdabenlv/ss.sh/releases/download/1.0.0/libsodium-$LIBSODIUM_VER.tar.gz
tar xvf libsodium-$LIBSODIUM_VER.tar.gz
pushd libsodium-$LIBSODIUM_VER
./configure --prefix=/usr && make
make install
popd
ldconfig

# Installation of MbedTLS
export MBEDTLS_VER=2.6.0
wget https://github.com/hntdabenlv/ss.sh/releases/download/1.0.0/mbedtls-$MBEDTLS_VER.tar.gz
tar xvf mbedtls-$MBEDTLS_VER.tar.gz
pushd mbedtls-mbedtls-$MBEDTLS_VER
make SHARED=1 CFLAGS="-O2 -fPIC"
make DESTDIR=/usr install
popd
ldconfig

# Installation of obfs
wget https://github.com/hntdabenlv/ss.sh/releases/download/1.0.0/simple-obfs.tar.gz
tar xvf simple-obfs.tar.gz
pushd simple-obfs
./autogen.sh && ./configure && make
make install
popd

# Start building
wget https://github.com/hntdabenlv/ss.sh/releases/download/1.0.0/shadowsocks-libev.tar.gz
tar xvf shadowsocks-libev.tar.gz
pushd shadowsocks-libev
./autogen.sh && ./configure && make
make install
popd

# add ports
firewall-cmd --zone=public --add-port=8000-10000/tcp --permanent
firewall-cmd --reload
#/etc/init.d/iptables stop

# auto run ss
mv runss.sh /etc/rc.d/init.d
chmod +x /etc/rc.d/init.d/runss.sh
pushd /etc/rc.d/init.d
chkconfig --add runss.sh
chkconfig runss.sh on
popd
