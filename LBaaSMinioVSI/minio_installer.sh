#!/usr/bin/env bash

installerlog="$HOME/install.log"
touch "$installerlog"

## Update system and install btrfs tools
sys_update() {
apt-get update
apt-get upgrade -y
apt-get install -y btrfs-tools  
} >> "$installerlog" 2>&1

mount_meta() {
mkdir /tmp/keys
mount /dev/xvdh /tmp/keys
msecret=$(cat /tmp/keys/openstack/latest/user_data | awk '{print $3}' | cut -d '=' -f2 | cut -d '"' -f1)
mskey=$(cat /tmp/keys/openstack/latest/user_data | awk '{print $1}' | cut -d '=' -f2 | cut -d '"' -f1)
}

## Create btrfs filesystem, mount it and update fstab
setup_btrfs() {
mkfs.btrfs /dev/xvdc /dev/xvde /dev/xvdf /dev/xvdg -f

mkdir /storage 
mount /dev/xvdc /storage

btuuid=$(lsblk --fs /dev/xvdc | grep -v UUID | awk '{print $3}')

echo "UUID=$btuuid /storage   btrfs  defaults 0 0" | sudo tee --append /etc/fstab
} >> "$installerlog" 2>&1

## Install minio binary and create default files
setup_minio() { 
wget -O /usr/local/bin/minio https://dl.minio.io/server/minio/release/linux-amd64/minio
chmod +x /usr/local/bin/minio
hostip=$(curl -s https://api.service.softlayer.com/rest/v3/SoftLayer_Resource_Metadata/getPrimaryBackendIpAddress | cut -d '"' -f2)

cat <<EOT >> /etc/default/minio
# Local export path.
MINIO_VOLUMES=http://node0.cde.services/storage http://node1.cde.services/storage http://node2.cde.services/storage http://node3.cde.services/storage
MINIO_OPTS="-C /etc/minio --address $hostip:9000"
MINIO_ACCESS_KEY="$mkey"
MINIO_SECRET_KEY="$msecret"
EOT

useradd -r minio-user -s /sbin/nologin
chown minio-user:minio-user /usr/local/bin/minio
chown minio-user:minio-user /storage

mkdir /etc/minio
chown minio-user:minio-user /etc/minio
wget -O /etc/systemd/system/minio.service https://raw.githubusercontent.com/minio/minio-service/master/linux-systemd/distributed/minio.service

systemctl enable minio.service
} >> "$installerlog" 2>&1

fix_hosts_issue() { 
sed -i "s/127.0.1.1/#127.0.1.1/g" /etc/hosts 
hostip=$(curl -s https://api.service.softlayer.com/rest/v3/SoftLayer_Resource_Metadata/getPrimaryBackendIpAddress | cut -d '"' -f2)
echo -e "$hostip\t$(hostname -f)\t$(hostname -s)" | tee -a /etc/hosts
}

sys_update 
mount_meta
setup_btrfs
setup_minio
fix_hosts_issue

sleep 300 && shutdown -r now
