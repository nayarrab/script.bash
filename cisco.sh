#!/bin/bash

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
echo " Starting Cisco Switch Configuration... "
echo "======================================"


sshpass -p '0' ssh -o StrictHostKeyChecking=no admin@192.168.27.3 "
enable
0
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
echo "write memory"

echo "======================================"
echo " Cisco Switch Configuration Completed! "
echo "======================================"
