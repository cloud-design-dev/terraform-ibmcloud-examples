#!/usr/bin/env bash 

MONITORINGKEY=$(grep apikey /tmp/tfmonitoring.key | awk '{print $2}' | cut -d '"' -f2)
SPACEID=$(cat /tmp/space.id)


apt-get update
apt-get install ntp -yq
apt-get install ntpdate collectd -yq
systemctl ntp stop 
ntpdate -u 0.ubuntu.pool.ntp.org
systemctl ntp start
systemctl ntp enable

wget -O - https://downloads.opvis.bluemix.net/client/IBM_Logmet_repo_install.sh | bash

apt-get install ibmcloud-monitoring -yq



export APIKEY="$MONITORINGKEY"
export METRIC_ENDPOINT="metrics.ng.bluemix.net"
export SpaceID="$SPACEID"

/opt/ibmcloud_monitoring/configure -e "$METRIC_ENDPOINT" -a "$APIKEY" -s s-"$SpaceID"

systemctl restart collectd
systemctl enable collectd

