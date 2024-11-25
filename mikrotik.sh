#!/bin/bash

clear

cat << "EOF" | lolcat
,---.   .--.   ____       ____     __   .-''-.   
|    \  |  | .'  __ `.    \   \   /  /.'_ _   \  
|  ,  \ |  |/   '  \  \    \  _. /  '/ ( ` )   ' 
|  |\_ \|  ||___|  /  |     _( )_ .'. (_ o _)  | 
|  _( )_\  |   _.-`   | ___(_ o _)' |  (_,_)___| 
| (_ o _)  |.'   _    ||   |(_,_)'  '  \   .---. 
|  (_,_)\  ||  _( )_  ||   `-'  /    \  `-'    / 
|  |    |  |\ (_ o _) / \      /      \       /  
'--'    '--' '.(_,_).'   `-..-'        `'-..-'   
                                                  
EOF

echo "======================================"
echo " Starting Mikrotik Configuration... "
echo "======================================"

MIKROTIK_IP="192.168.27.4" 
MIKROTIK_USER="admin"      
MIKROTIK_PASS="0"   

CONFIG_COMMANDS="
/ip dhcp-client add interface=ether1 disabled=no
/ip address add address=192.168.200.1/24 interface=ether2
/ip pool add name=dhcp_pool_ether2 ranges=192.168.200.10-192.168.200.100
/ip dhcp-server add address-pool=dhcp_pool_ether2 interface=ether2 lease-time=1h name=dhcp_server_ether2
/ip dhcp-server network add address=192.168.200.0/24 gateway=192.168.200.1
"

echo "Starting configuration for MikroTik at $192.168.27.4..."

# Kirim perintah konfigurasi menggunakan sshpass
sshpass -p "0" ssh -o StrictHostKeyChecking=no "$admin@$192.168.27.4" << EOF
$CONFIG_COMMANDS
EOF

echo "======================================"
echo " Mikrotik Configuration Completed! "
echo "======================================"