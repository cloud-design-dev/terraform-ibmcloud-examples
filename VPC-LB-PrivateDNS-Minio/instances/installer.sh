#!/bin/bash

installerlog="/tmp/install.log"
touch "$installerlog"

## Update system and install btrfs tools
sys_update() {
DEBIAN_FRONTEND=noninteractive apt -qqy update
DEBIAN_FRONTEND=noninteractive apt-get -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' upgrade
DEBIAN_FRONTEND=noninteractive apt -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' install python3-apt python3-pip curl wget unzip jq btrfs-tools  
} >> "$installerlog" 2>&1

checkin() {
curl -X POST --data-urlencode "payload={\"channel\": \"#ibmcloud\", \"username\": \"webhookbot\", \"text\": \"System `hostname -s` has come online system with a primary ip of: `hostname -I`\"}, \"icon_emoji\": \":ghost:\"}" "https://hooks.slack.com/services/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"
} >> "$installerlog" 2>&1

sys_update
checkin