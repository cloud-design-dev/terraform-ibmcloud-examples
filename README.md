# IBM Cloud Terraform Examples
The following examples will demonstrate how to deploy a wide variety of infrastructure and services on the IBM Cloud. See the [official docs](https://cloud.ibm.com/docs/terraform?topic=terraform-index-of-terraform-resources-and-data-sources) for all the data and resource types supported by the [IBM Cloud Provider](https://github.com/IBM-Cloud/terraform-provider-ibm)

## Prerequisites
* [Terraform installed](https://www.terraform.io/intro/getting-started/install.html)
* [IBM Cloud Classic IaaS Username / API Key](https://cloud.ibm.com/docs/account?topic=account-classic_keys) # This is only required if deploying classic resources
* [IBM Cloud Classic IaaS SSH Key](https://cloud.ibm.com/docs/ssh-keys?topic=ssh-keys-adding-an-ssh-key#adding-an-ssh-key)
* [IBM Cloud API Key](https://cloud.ibm.com/docs/account?topic=account-userapikey#create_user_key)
* [IBM Cloud VPC SSH Key](https://cloud.ibm.com/docs/vpc?topic=vpc-ssh-keys)

> The examples in this respository are currently being ported to work with Terraform 0.13 and above. If you would like to work with multiple versions of Terraform on the same machine take a look at [tfswitch](https://github.com/warrensbox/terraform-switcher).

### Examples that have been ported to Terraform v0.13 syntax:
 - [Classic Bare Metal Server](ClassicVSI-BlockStorage/README.md)
 - [Classic VSI with Block Storage](BlockVSI/README.md)
 - [Classic VSI with File Storage](ClassicVSI-FileStorage/README.md)
 - [Classic VSI with Cloud Load Balancer](ClassicVSI-LBaaS/README.md)
 - [Classic VSI with LogDNA integration](ClassicVSI-LogDNA/README.md)
 - [Classic VSI with custom security group](ClassicVSI-SecurityGroups/README.md)
 - [Classic VSI with Windows and cloud-init](ClassicVSI-WindowsCloudInit/README.md)
 - [Cloud Object Storage and Buckets](Cloud-Object-Storage/README.md)
 - [VPC Single Zone deployment](VPC-SingleZone/README.md)
 - [VPC with Flow Logs](VPC-Flowlogs/README.md)