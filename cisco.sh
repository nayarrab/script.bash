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

echo -e "${Yellow}${PROGRES[11]}${NC}"
CISCO_IP="192.168.187.138"
CISCO_PORT="30013"
expect <<EOF >/dev/null 2>&1
spawn telnet $CISCO_IP $CISCO_PORT
set timeout 22

expect ">" { send "enable\r" }
expect "(config)#" { send "configure terminal\r" }
expect "(config)#" { send "interface Ethernet0/1\r" }
expect "(config-if)#" { send "switchport mode access\r" }
expect "(config-if)#" { send "switchport access vlan 10\r" }
expect "(config-if)#" { send "no shutdown\r" }
expect "(config-if)#" send "exit\r" }
expect "(config)#" { send "interface Ethernet0/7\r" }
expect "(config-if)#" { send "switchport trunk encapsulation dot1q\r" }
expect "(config-if)#" { send "switchport mode trunk\r" }
expect "(config-if)#" { send "no shutdown\r" }
expect "(config-if)#" { send "exit\r" }
expect "(config-if)#" { send "end" }
expect eof
EOF
