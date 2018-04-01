#!/usr/bin/env bash 

HST=$(hostname -s)
LA_TENANT_ID=$(tail -n1 /tmp/logtoken | awk '{print $1}')
LA_TOKEN=$(tail -n1 /tmp/logtoken | awk '{print $2}')

apt-get update
apt-get install ntp -yq
apt-get install ntpdate
systemctl ntp stop 
ntpdate -u 0.ubuntu.pool.ntp.org
systemctl ntp start
systemctl ntp enable

wget -O - https://downloads.opvis.bluemix.net/client/IBM_Logmet_repo_install.sh | bash

apt-get install mt-logstash-forwarder -y 

mv /tmp/mt-lsf-config.sh /etc/mt-logstash-forwarder/mt-lsf-config.sh

sed -i "s|instanceid|$HST|" /etc/mt-logstash-forwarder/mt-lsf-config.sh
sed -i "s|tenantid|$LA_TENANT_ID|" /etc/mt-logstash-forwarder/mt-lsf-config.sh
sed -i "s|latoken|$LA_TOKEN|" /etc/mt-logstash-forwarder/mt-lsf-config.sh

systemctl start mt-logstash-forwarder
systemctl enable mt-logstash-forwarder

