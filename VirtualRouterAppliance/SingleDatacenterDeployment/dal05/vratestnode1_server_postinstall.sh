#!/usr/bin/env bash

gwip=$(grep -E '10.0.' /etc/sysconfig/network-scripts/route-eth0 | awk '{print $3}')
echo -e "IPADDR2=192.168.30.5\nPREFIX=24\nIPADDR3=192.168.40.5\nPREFIX=24" | tee -a /etc/sysconfig/network-scripts/ifcfg-eth0
echo -e "192.168.10.0/24 via ${gwip} dev bond0\n192.168.20.0/24 via ${gwip} dev bond0" | tee -a /etc/sysconfig/network-scripts/route-eth0