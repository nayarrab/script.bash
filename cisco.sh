#!/bin/bash

CISCO_IP="192.168.27.2"
CISCO_USER="admin"
CISCO_PASS="123"

CONFIG_COMMANDS="
enable
configure terminal
vlan 10
name Management
exit
interface e0/0
switchport trunk encapsulation dot1q
switchport mode trunk
exit
interface e0/1
switchport mode access
switchport access vlan 10
exit
write memory
"

sshpass -p "$CISCO_PASS" ssh -o StrictHostKeyChecking=no "$CISCO_USER@$CISCO
