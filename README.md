# Initial Configuration

## Prerequisites
* [Terraform installed](https://www.terraform.io/intro/getting-started/install.html)
* [IBM Cloud Classic API Key](https://cloud.ibm.com/docs/account?topic=account-classic_keys) # This is only required if deploying classic resources
* [IBM Cloud API Key](https://cloud.ibm.com/docs/account?topic=account-userapikey#create_user_key)

> The examples in this respository are currently being ported to work with Terraform 0.13 and above. If you would like to work with multiple versions of Terraform on the same machine take a look at [tfswitch](https://github.com/warrensbox/terraform-switcher).

### Examples that have been ported to Terraform v0.13 syntax:
 - [Bare Metal](BareMetalServer/README.md)
 - [Block storage with Classic VSI](BlockVSI/README.md)
 - [File storage with Classic VSI](FileStorageVSI/README.md)
 - [Cloud Object Storage and Buckets](Cloud-Object-Storage/README.md)
 - [VPC Gen 2](VPC-Gen2/README.md)