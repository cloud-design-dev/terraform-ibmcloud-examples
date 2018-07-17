#!/usr/bin/env bash

echo -n -e "Please supply the Public Peer IP of your remote VRA  "
read -r VRA_PUBLIC_PEER

echo -n -e "Please supply the Private Peer IP of your remote VRA  "
read -r VRA_PRIVATE_PEER

echo -n -e "Please supply the Public Local Peer IP of this VRA  "
read -r VRA_PUBLIC_LOCAL_PEER

echo -n -e "Please supply the Private Local Peer IP of this VRA  "
read -r VRA_PRIVATE_LOCAL_PEER

echo -n -e "Please supply the pre-shared-secret to be used for your tunnels (this most be set the same on both VRAs)  "
read -r VRA_SECRET

sed -i "s|PUBLIC_PEER_IP|$VRA_PUBLIC_PEER|g" /tmp/wdc07create-tunnels.vcli 
sed -i "s|PRIVATE_PEER_IP|$VRA_PRIVATE_PEER|g" /tmp/wdc07create-tunnels.vcli 
sed -i "s|PUBLIC_LOCAL_PEER_IP|$VRA_PUBLIC_LOCAL_PEER|g" /tmp/wdc07create-tunnels.vcli 
sed -i "s|PRIVATE_LOCAL_PEER_IP|$VRA_PRIVATE_LOCAL_PEER|g" /tmp/wdc07create-tunnels.vcli 
sed -i "s|PASSWORD|$VRA_SECRET|g" /tmp/wdc07create-tunnels.vcli 

echo -e "Now run the following command to create the ipsec tunnels:\n\n/tmp/wdc07create-tunnels.vcli\n"