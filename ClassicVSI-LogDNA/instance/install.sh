#!/bin/bash 

## Update machine
DEBIAN_FRONTEND=noninteractive apt -qqy update
DEBIAN_FRONTEND=noninteractive apt-get -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' upgrade

## Install LogDNA
echo "deb https://repo.logdna.com stable main" | tee /etc/apt/sources.list.d/logdna.list
wget -O- https://repo.logdna.com/logdna.gpg | apt-key add -
DEBIAN_FRONTEND=noninteractive apt -qqy update
DEBIAN_FRONTEND=noninteractive apt-get install logdna-agent < "/dev/null"
logdna-agent -k ${ingestion_key}

logdna-agent -s LOGDNA_APIHOST=api.${region}.logging.cloud.ibm.com
logdna-agent -s LOGDNA_LOGHOST=logs.${region}.logging.cloud.ibm.com

logdna-agent -t `hostname -s`
update-rc.d logdna-agent defaults
/etc/init.d/logdna-agent start