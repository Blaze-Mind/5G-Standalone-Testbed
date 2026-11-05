#!/bin/bash
# 5G Standalone Testbed Routing Setup for WSL
# This script configures the Linux kernel and iptables to allow Open5GS and UERANSIM to bridge to the internet.

echo "Disabling Reverse Path Filtering to prevent routing loops..."
sudo sysctl -w net.ipv4.conf.all.rp_filter=0
sudo sysctl -w net.ipv4.conf.default.rp_filter=0
sudo sysctl -w net.ipv4.conf.ogstun.rp_filter=0

echo "Configuring NAT and IP Forwarding for the 5G subnet..."
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -I POSTROUTING -s 10.45.0.0/16 -o eth0 -j MASQUERADE

echo "Opening WSL Firewall for 5G Core and UE interfaces..."
sudo iptables -I FORWARD -i ogstun -j ACCEPT
sudo iptables -I FORWARD -o ogstun -j ACCEPT
sudo iptables -I FORWARD -i uesimtun0 -j ACCEPT
sudo iptables -I FORWARD -o uesimtun0 -j ACCEPT

echo "Restarting UPF Service to bind new rules..."
sudo service open5gs-upfd restart

echo "5G Routing Configuration Complete!"