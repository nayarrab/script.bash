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

#!/usr/bin/expect

# Variabel koneksi
set timeout 20
set IP "192.168.187.137"         ;# Ganti dengan IP perangkat Cisco
set USER "admin"             ;# Username perangkat Cisco
set PASS "password123"       ;# Password perangkat Cisco
set ENABLE_PASS "enable123"  ;# Password untuk mode enable

# Membuka koneksi SSH ke Cisco
spawn ssh $USER@$IP

# Login SSH
expect {
    "yes/no" { send "yes\r"; exp_continue }
    "Password:" { send "$PASS\r" }
}

# Masuk ke mode enable
expect ">"
send "enable\r"
expect "Password:"
send "$ENABLE_PASS\r"

# Masuk ke mode konfigurasi
expect "#"
send "configure terminal\r"

# Konfigurasi VLAN 10
expect "(config)#"
send "vlan 10\r"
expect "(config-vlan)#"
send "name MANAGER\r"
expect "(config-vlan)#"
send "exit\r"

# Konfigurasi Interface Trunk pada Ethernet0/0
send "interface Ethernet0/0\r"
expect "(config-if)#"
send "switchport trunk encapsulation dot1q\r"
expect "(config-if)#"
send "switchport mode trunk\r"
expect "(config-if)#"
send "no shutdown\r"
send "exit\r"

# Konfigurasi Interface Access pada Ethernet0/1
send "interface Ethernet0/1\r"
expect "(config-if)#"
send "switchport mode access\r"
expect "(config-if)#"
send "switchport access vlan 10\r"
expect "(config-if)#"
send "no shutdown\r"
send "exit\r"

# Simpan konfigurasi
expect "(config)#"
send "end\r"
expect "#"
send "write memory\r"

# Keluar dari sesi
expect "#"
send "exit\r"

# Selesai
expect eof

EOF
