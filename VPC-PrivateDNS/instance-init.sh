#!/bin/bash

## Update machine
DEBIAN_FRONTEND=noninteractive apt -qqy update
DEBIAN_FRONTEND=noninteractive apt-get -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' upgrade

## Install Dependencies
DEBIAN_FRONTEND=noninteractive apt -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' install apache2 curl wget unzip

echo "$(hostname -s).cde.local" | tee -a /tmp/new_index.html 

mv /var/www/html/index.html{,.bak}
mv /tmp/new_index.html /var/www/html/index.html

systemctl restart apache2

## Configure Private DNS
cat > /etc/netplan/99-custom-dns.yaml << EOF
network:
  version: 2
  ethernets:
    ens3:
      nameservers:
        addresses: [ "161.26.0.7", "161.26.0.8" ]
      dhcp4-overrides:
        use-dns: false
EOF

## Apply changes to Netplan
netplan apply

## Configure DHCP to use Private DNS resolvers
cat >> /etc/dhcp/dhclient.conf << EOF
# added by cloud-init configuration
# resolve names against private dns
supersede domain-name-servers 161.26.0.7, 161.26.0.8;
# and allow short names to be searched so <somehost>.cde.local can be resolved with just <somehost>
supersede domain-search "cde.local";
EOF

## Flush system cache
dhclient -v -r; dhclient -v
systemd-resolve --flush-caches
