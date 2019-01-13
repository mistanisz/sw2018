#!/bin/bash

# run as root

URL='https://serverfault.com/questions/152363/bridging-wlan0-to-eth0'
IFCONFIG_WLAN='wlp2s0'
IFCONFIG_ETH='enp3s0'

echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o $IFCONFIG_WLAN -j MASQUERADE
ifconfig $IFCONFIG_ETH 10.0.0.1 netmask 255.255.255.0 up
dhcpd $IFCONFIG_ETH
ps aux | grep dhcpd
