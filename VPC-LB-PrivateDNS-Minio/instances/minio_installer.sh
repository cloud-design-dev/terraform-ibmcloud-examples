#!/bin/bash

installerlog="/tmp/install.log"
touch "$installerlog"

## Update system and install btrfs tools
sys_update() {
DEBIAN_FRONTEND=noninteractive apt -qqy update
DEBIAN_FRONTEND=noninteractive apt-get -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' upgrade
DEBIAN_FRONTEND=noninteractive apt -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' install python3-apt python3-pip curl wget unzip jq btrfs-tools  
} >> "$installerlog" 2>&1

## Create btrfs filesystem, mount it and update fstab
setup_btrfs() {
mkfs.btrfs /dev/vdd -f

mkdir /storage 
mount /dev/vdd  /storage

btuuid=$(lsblk --fs /dev/vdd | grep -v UUID | awk '{print $3}')

echo "UUID=$btuuid /storage   btrfs  defaults 0 0" | sudo tee --append /etc/fstab
} >> "$installerlog" 2>&1

# ## Install minio binary and create default files
# setup_minio() { 
# wget -O /usr/local/bin/minio https://dl.minio.io/server/minio/release/linux-amd64/minio
# chmod +x /usr/local/bin/minio

# cat <<EOT >> /etc/default/minio
# # Local export path.
# MINIO_VOLUMES=http://node0.cde.services/storage http://node1.cde.services/storage http://node2.cde.services/storage 
# MINIO_OPTS="-C /etc/minio --address `hostname -I`:9000"
# MINIO_ACCESS_KEY="${access_key"
# MINIO_SECRET_KEY="${secret_key}"
# EOT

# useradd -r minio-user -s /sbin/nologin
# chown minio-user:minio-user /usr/local/bin/minio
# chown minio-user:minio-user /storage

# mkdir /etc/minio
# chown minio-user:minio-user /etc/minio
# wget -O /etc/systemd/system/minio.service https://raw.githubusercontent.com/minio/minio-service/master/linux-systemd/distributed/minio.service

# systemctl enable minio.service
# } >> "$installerlog" 2>&1

# fix_hosts_issue() { 
# sed -i "s/127.0.1.1/#127.0.1.1/g" /etc/hosts 
# hostip=$(curl -s https://api.service.softlayer.com/rest/v3/SoftLayer_Resource_Metadata/getPrimaryBackendIpAddress | cut -d '"' -f2)
# echo -e "$hostip\t$(hostname -f)\t$(hostname -s)" | tee -a /etc/hosts
# }

checkin() {
curl -X POST --data-urlencode "payload={\"channel\": \"#ibmcloud\", \"username\": \"webhookbot\", \"text\": \"System `hostname -s` has come online system with a primary ip of: `hostname -I`\"}, \"icon_emoji\": \":ghost:\"}" "https://hooks.slack.com/services/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"
} >> "$installerlog" 2>&1

sys_update
setup_btrfs
checkin