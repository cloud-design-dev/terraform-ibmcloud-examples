#!/usr/bin/env bash

gwip=$(grep -E '10.0.' /etc/sysconfig/network-scripts/route-eth0 | awk '{print $3}')
echo -e "IPADDR2=192.168.10.5\nPREFIX=24\nIPADDR3=192.168.20.5\nPREFIX=24" | tee -a /etc/sysconfig/network-scripts/ifcfg-eth0
echo -e "192.168.30.0/24 via ${gwip} dev bond0\n192.168.40.0/24 via ${gwip} dev bond0" | tee -a /etc/sysconfig/network-scripts/route-eth0

yum update -y
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum install iperf3 -y

mkdir /vratesting
touch /vratesting/publicTunnelTCPTest.json
touch /vratesting/privateTunnelTCPTest.json

cat << EOF > /vratesting/publictest.sh
#!/bin/bash
iperf3 -c 192.168.30.5 -B 192.168.10.5 -p 5205 -fM -P 10 -J -t1200 --get-server-output | tee -a /vratesting/publicTunnelTCPTest.json
EOF

cat << EOF > /vratesting/privatetest.sh
#!/bin/bash
iperf3 -c 192.168.40.5 -B 192.168.20.5 -p 5210 -fM -P 10 -J -t1200 --get-server-output | tee -a /vratesting/privateTunnelTCPTest.json
EOF

chmod + /vratesting/publictest.sh
chmod + /vratesting/privatetest.sh

crontab -l | { cat; echo "0 1,2,3,4,5,6 * * * /bin/bash /vratesting/publictest.sh > /dev/null 2>&1"; } | crontab -
crontab -l | { cat; echo "0 7,8,9,10,11,12 * * * /bin/bash /vratesting/privatetest.sh > /dev/null 2>&1"; } | crontab -