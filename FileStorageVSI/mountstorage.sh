#!/usr/bin/env bash

DEBIAN_FRONTEND=noninteractive apt-get update 
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -qq
DEBIAN_FRONTEND=noninteractive apt-get install -y nfs-common

mkdir -p /mnt/test

storage=$(cat /tmp/mountpath.txt)

mount -t nfs4 -o hard,intr ${storage} /mnt/test

echo -e "${storage}\t/mnt/test\tnfs4\tdefaults,hard,intr\t0\t0" | tee -a /etc/fstab

