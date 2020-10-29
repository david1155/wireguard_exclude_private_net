#!/usr/local/bin/bash

INTERFACE=$(ifconfig | grep -B1 "192.168.200.200" | awk '$1!="inet" && $1!="--" {print $1}'| awk '{t=length($0)}END{print substr($0,0,t-1)}')
PUBLIC_NET=($(/usr/local/bin/python3 /usr/local/etc/wireguard/generate_subnets.py))

for i in "${PUBLIC_NET[@]}"
do
	route -q -n add -inet $i -interface $INTERFACE
done