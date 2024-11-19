#!/bin/bash
echo "Installing DHCP server..."
sudo apt update
sudo apt install -y isc-dhcp-server

echo "Configuring DHCP server..."
sudo bash -c 'cat <<EOT > /etc/dhcp/dhcpd.conf
subnet 192.168.27.0 netmask 255.255.255.0 {
    range 192.168.27.10 192.168.27.100;
    option routers 192.168.27.1;
    option domain-name-servers 8.8.8.8, 8.8.4.4;
}
EOT'

INTERFACE="eth1.10"
echo "Configuring DHCP interface..."
sudo sed -i "s/^INTERFACESv4=.*/INTERFACESv4=\"$INTERFACE\"/" /etc/default/isc-dhcp-server

echo "Restarting DHCP server..."
sudo systemctl restart isc-dhcp-server
echo "Enabling DHCP server to start on boot..."
sudo systemctl enable isc-dhcp-server

echo "DHCP server setup completed."
