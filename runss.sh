#!/bin/bash
# chkconfig: 2345 10 90
# description: 启动ss
#rngd -r /dev/urandom
#nohup ss-server -p 8888 -k qwa2018Q -m xchacha20-ietf-poly1305 -u --fast-open --plugin obfs-server --plugin-opts "obfs=tls" >/root/ss.log 2>&1 & #启动ss
nohup ss-server -p 8888 -k qwa2018Q -m xchacha20-ietf-poly1305 -u --plugin obfs-server --plugin-opts "obfs=tls" >/root/ss.log 2>&1 & #启动ss
