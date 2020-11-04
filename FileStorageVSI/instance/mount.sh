#!/usr/bin/env bash

DEBIAN_FRONTEND=noninteractive apt-get update 
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -qq
DEBIAN_FRONTEND=noninteractive apt-get install -y nfs-common

mkdir -p /mnt/test

mount -t nfs4 -o hard,intr ${mountpoint} /mnt/test

echo -e "${mountpoint}\t/mnt/test\tnfs4\tdefaults,hard,intr\t0\t0" | tee -a /etc/fstab

