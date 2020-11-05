# Initial Configuration

## Prerequisites
* [Terraform installed](https://www.terraform.io/intro/getting-started/install.html)
* [IBM Cloud Classic API Key](https://cloud.ibm.com/docs/account?topic=account-classic_keys) # This is only required if deploying classic resources
* [IBM Cloud API Key](https://cloud.ibm.com/docs/account?topic=account-userapikey#create_user_key)

> The examples in this respository are currently being ported to work with Terraform 0.13 and above. If you would like to work with multiple versions of Terraform on the same machine take a look at [tfswitch](https://github.com/warrensbox/terraform-switcher).

### Examples that have been ported to Terraform v0.13 syntax:
 - [Classic Bare Metal Server](ClassicVSI-BlockStorage/README.md)
 - [Classic VSI with Block Storage](BlockVSI/README.md)
 - [Classic VSI with File Storage](ClassicVSI-FileStorage/README.md)
 - [Classic VSI with Cloud Load Balancer](ClassicVSI-LBaaS/README.md)
 - [Classic VSI with LogDNA integration](ClassicVSI-LogDNA/README.md)
 - [Classic VSI with custom security group](ClassicVSI-SecurityGroups/README.md)
 - [Cloud Object Storage and Buckets](Cloud-Object-Storage/README.md)
 - [VPC Gen 2](VPC-Gen2/README.md)
