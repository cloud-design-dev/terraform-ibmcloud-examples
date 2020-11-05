#!/bin/bash

DEBIAN_FRONTEND=noninteractive apt-get update 
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
 
DEBIAN_FRONTEND=noninteractive apt install wget multipath-tools python3-pip jq -y 

pip3 install softlayer

cat <<EOF > /root/.softlayer
[softlayer]
username = ${sl_username}
api_key = ${sl_api_key}
endpoint_url = https://api.softlayer.com/xmlrpc/v3.1/
timeout = 120
EOF

wget -O /tmp/initiatorname.iscsi https://raw.githubusercontent.com/greyhoundforty/IBMCloud-Terraform-Examples/master/BlockVSI/initiatorname.iscsi
wget -O /tmp/iscsi-example.conf https://raw.githubusercontent.com/greyhoundforty/IBMCloud-Terraform-Examples/master/BlockVSI/iscsi-example.conf

service multipath-tools start

blockiqn=`slcli --config /root/.softlayer --format json block access-list ${block_id} | jq -r '.[] | .host_iqn'`
sed -i "s|DEFAULTIQN|$blockiqn|" /tmp/initiatorname.iscsi
mv /etc/iscsi/initiatorname.iscsi{,.bak}
mv /tmp/initiatorname.iscsi /etc/iscsi/initiatorname.iscsi


blockusername=`slcli --config /root/.softlayer --format json block access-list ${block_id} | jq -r '.[] | .username'`
sed -i "s|BLOCK_USERNAME|$blockusername|g" /tmp/iscsi-example.conf

blockpass=`slcli --config /root/.softlayer --format json block access-list ${block_id} | jq -r '.[] | .password'`
sed -i "s|BLOCK_PASSWORD|$blockpass|g" /tmp/iscsi-example.conf

mv /etc/iscsi/iscsid.conf{,.bak}
mv /tmp/iscsi-example.conf /etc/iscsi/iscsid.conf

systemctl restart iscsi
systemctl restart iscsid

iscsiadm -m discovery -t sendtargets -p ${target_ip}
iscsiadm -m node --login
fdisk -l | grep /dev/mapper
