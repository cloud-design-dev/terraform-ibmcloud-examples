# Deploying a VSI and ICOS

This terraform example will deploy an IBM Cloud VSI and Cloud Object Storage. A post-install script will then automatically configure the VSI to use rsync, rsnapshot and s3cmd to backup the VSI to the Cloud Object Storage account.

