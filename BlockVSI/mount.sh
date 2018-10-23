#!/bin/bash

echo "things" > /tmp/temp.txt

apt-get update 
apt-get upgrade -y

apt install multipath-tools -y 

service multipath-tools start

blockiqn=$(cat /tmp/mountpath.txt | awk '{print $1}' | cut -d ':' -f2,3- | cut -d ']' -f1)
sed -i "s|DEFAULTIQN|$blockiqn|" /tmp/initiatorname.iscsi
mv /etc/iscsi/initiatorname.iscsi{,.bak}
mv /tmp/initiatorname.iscsi /etc/iscsi/initiatorname.iscsi


blockusername=$(cat /tmp/mountpath.txt | awk '{print $4}' | cut -d ':' -f2 | cut -d ']' -f1)
sed -i "s|BLOCK_USERNAME|$blockusername|g" /tmp/iscsi-example.conf

blockpass=$(cat /tmp/mountpath.txt | awk '{print $3}' | cut -d ':' -f2 | cut -d ']' -f1)
sed -i "s|BLOCK_PASSWORD|$blockpass|g" /tmp/iscsi-example.conf

mv /etc/iscsi/iscsid.conf{,.bak}
mv /tmp/iscsi-example.conf /etc/iscsi/iscsid.conf

systemctl restart iscsi
systemctl restart iscsid

# iscsiadm -m discovery -t sendtargets -p
