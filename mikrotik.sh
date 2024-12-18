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
echo " Starting Mikrotik Configuration... "
echo "======================================"

expect {
    "Password changed" {
        puts "Password berhasil diubah."
    }
    "Try again. Error: New passwords do not match!" {
        puts "Password tidak cocok. Ulangi pengisian password."
        send "0\r"
        expect "Repeat new password" { send "0\r" }
        expect "Password changed" { puts "Password berhasil diubah." }
    }
    timeout {
        puts "Login berhasil tanpa perubahan password."
    }
}

expect ">" { puts "Konfigurasi MikroTik dimulai." }

send "/ip address add address=192.168.200.1/24 interface=ether2\r"
expect ">"

send "/ip firewall nat add chain=srcnat out-interface=ether1 action=masquerade\r"
expect ">"

send "/ip route add gateway=192.168.27.1\r"
expect ">"

send "/ip dhcp-server setup\r"
expect "Select interface" { send "ether2\r" }
expect "Select address pool" { send "dhcp_pool\r" }
expect "Select gateway" { send "192.168.200.1\r" }
expect "Select DNS" { send "8.8.8.8\r" }
expect "Configure DHCP server" { send "yes\r" }
expect ">"
