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
echo " Starting Cisco Switch Configuration... "
echo "======================================"


echo "[1/2] Configuring VLAN and Trunk..."
echo "vlan 10" 

echo "interface fastEthernet 0/0"
echo "switchport trunk encapsulation dot1q"
echo "switchport mode trunk"
echo "switchport trunk allowed vlan 10"
echo "exit"

echo "interface fastEthernet 0/1"
echo "switchport mode access"
echo "switchport access vlan 10"
echo "exit"

echo "[2/2] Cisco Configuration Completed!"

echo "======================================"
echo " Cisco Switch Configuration Completed! "
echo "======================================"
