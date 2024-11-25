#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

clear

echo ",---.   .--.   ____       ____     __   .-''-.   "
echo "|    \  |  | .'  __ \`.    \   \   /  /.'_ _   \  "
echo "|  ,  \ |  |/   '  \  \    \  _. /  '/ ( \` )   ' "
echo "|  |\_ \|  ||___|  /  |     _( )_ .'. (_ o _)  | "
echo "|  _( )_\  |   _.-\`   | ___(_ o _)' |  (_,_)___| "
echo "| (_ o _)  |.'   _    ||   |(_,_)'  '  \   .---. "
echo "|  (_,_)\  ||  _( )_  ||   \`-'  /    \  \`-'    / "
echo "|  |    |  |\ (_ o _) / \      /      \       /  "
echo "'--'    '--' '.(_,_).'   \`-..-'        \`'-..-'   "
echo "                                                 "
echo "======================================"
echo " Starting DHCP Server Configuration... "
echo "======================================"

set -e 

echo "[1/4] Update Repository..."
cat <<EOF | sudo tee /etc/apt/sources.list 
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-updates main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-security main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-backports main restricted universe multiverse
deb http://kartolo.sby.datautama.net.id/ubuntu/ focal-proposed main restricted universe multiverse
EOF

sudo apt update /dev/null 2>&1

echo "[2/4] Configurig Ip Address..."
cat <<EOF | sudo tee /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets: 
    eth0:
      dhcp4: true
  ethernets:
    eth1:
      dhcp4: no
  vlans:
    eth1.10:
      id: 10
      link: eth1
      addresses: [192.168.27.1/24]
EOF

sudo netplan apply /dev/null 2>&1

echo "[3/4] Installing DHCP Server..."
sudo apt install -y isc-dhcp-server iptables iptables-persistent /dev/null 2>&1

cat <<EOF | sudo tee /etc/dhcp/dhcpd.conf
  # A slightly different configuration for an internal subnet.
  subnet 192.168.27.0 netmask 255.255.255.0 {
    range 192.168.27.10 192.168.27.100;
    option domain-name-servers 192.168.27.1, 8.8.8.8, 8.8.4.4;
    option subnet-mask 255.255.255.0;
    option routers 192.168.27.1;
    option broadcast-address 192.168.27.255;
    default-lease-time 600;
    max-lease-time 7200;
  }
EOF

echo "[4/4] Restarting DHCP Server..."
sudo /etc/init.d/isc-dhcp-server restart /dev/null 2>&1

sudo sed -i 's/^INTERFACES4=.*/INTERFACESV4="eth1.10"/' /etc/default/isc-dhcp-server

sudo /etc/init.d/isc-dhcp-server restart /dev/null 2>&1

sudo apt install -y iptables /dev/null 2>&1

sudo sysctl -w net.ipv4.ip_forward=1 /dev/null 2>&1
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf 
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE /dev/null 2>&1

sudo netfilter-persistent save

echo "======================================"
echo " DHCP Server Configuration Completed! "
echo "======================================"
