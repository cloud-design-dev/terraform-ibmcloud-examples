#!/usr/bin/env bash

## Variables
set_install_variables() {
COS_ACCESS_KEY=$(grep access_key_id /tmp/tfcostest.coskey | awk '{print $2}' | cut -d '"' -f 2)
COS_SECRET_KEY=$(grep secret_access_key /tmp/tfcostest.coskey | awk '{print $2}' | cut -d '"' -f 2)
COS_ENDPOINT="s3-api.us-geo.objectstorage.service.networklayer.com"
HST=$(hostname -s)
BUCKET="$RANDOM-$HST"
}


configure_os() {
DEBIAN_FRONTEND=noninteractive apt-get update
DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq 
DEBIAN_FRONTEND=noninteractive apt-get install rsnapshot s3cmd wget rsync -yq 
mv /etc/rsnapshot.conf{,.bak}
mv /tmp/rsnapshot.conf /etc/rsnapshot.conf
wget -O /etc/cron.d/rsnapshot https://raw.githubusercontent.com/greyhoundforty/COSTooling/master/rsnapshotcron 
}

configure_s3cmd() {

mv /tmp/s3cfg /etc/.s3cfg

sed -i "s|cos_access_key|$COS_ACCESS_KEY|" /etc/.s3cfg
sed -i "s|cos_secret_key|$COS_SECRET_KEY|" /etc/.s3cfg
sed -i "s|cos_endpoint|$COS_ENDPOINT|g" /etc/.s3cfg

$(which s3cmd) --config=/etc/.s3cfg mb s3://"$BUCKET"

}

# Set a basic daily cron to compress our rsnapshot backup directory and send it to s3cmd 
cos_backup_schedule() { 
wget -O /usr/local/bin/coscron.sh https://raw.githubusercontent.com/greyhoundforty/COSTooling/master/coscron.sh
chmod +x /usr/local/bin/coscron.sh
sed -i "s|COSBUCKET|$BUCKET|g" /usr/local/bin/coscron.sh 

echo "00 22 * * * root $(which bash) /usr/local/bin/coscron.sh" > "$HOME/dailybackup"
mv "$HOME/dailybackup" /etc/cron.d/
}

set_install_variables
configure_os
configure_s3cmd
cos_backup_schedule
