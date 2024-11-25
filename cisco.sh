#!/bin/bash

clear

echo "======================================"
echo "     Welcome to Nayarra Automation       "
echo "======================================"
echo "                                       "
echo "    _   _   __     __  ______  ______  "
echo "   | \ | |  \ \   / / |  ____||  ____| "
echo "   |  \| |   \ \/ /  | |_   | |__    "
echo "   | . ` |    \   /   |  __|  |  __|   "
echo "   | |\  |     | |    | |____ | |____  "
echo "   || \|     ||    |||_| "
echo "                                       "
echo "======================================"
echo " Starting Cisco Configuration... "
echo " 

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
echo " Cisco Configuration Completed!       "
echo "======================================"
