## Prerequisites  
- [Terraform installed](https://www.terraform.io/intro/getting-started/install.html)
- [IBM Cloud Provider Binary installed](https://github.com/IBM-Cloud/terraform-provider-ibm/releases)

## Configure Terraform  
Create a `~/.terraformrc` file that points to the Terraform binary. For example if you installed the binary to `/usr/local/bin/terraform-provider-ibm` the `~/.terraformrc` would look like this:

```hcl
providers {
    ibm = "/usr/local/bin/terraform-provider-ibm"
}
```

## Configure Plugin to work with Terraform

To provide your credentials as environment variables, you can use the following code in your `provider.tf` file. *Please Note*: for the Kubernetes example you also need to add the region to the `provider.tf` file. 

```hcl
provider "ibm" {
   bluemix_api_key    = "${var.ibm_bx_api_key}"
   softlayer_username = "${var.ibm_sl_username}"
   softlayer_api_key  = "${var.ibm_sl_api_key}"
}
```

Be sure to also define at minimum the following variables in your `var.tf` files:

```hcl
variable ibm_bx_api_key {}
variable ibm_sl_username {}
variable ibm_sl_api_key {}
```

For any example that also deploys a PaaS offering you may also need to add:

```
variable ibm_account_guid {}
variable ibm_org_guid {}
variable ibm_space_guid {}
```

If you do not know your IBM Account/Org/Space GUID you can run the following commands to obtain them:

```shell
# Get account guid 
$ ibmcloud iam accounts

# Get Org guid
$ ibmcloud iam orgs --guid

# Get Space guid
$ ibmcloud iam space <SPACE NAME> --guid
```

With those gathered you can now export your environmental variables for use with Terraform. 

```shell
export TF_VAR_ibm_bx_api_key="$VALUE"
export TF_VAR_ibm_sl_username="$VALUE"
export TF_VAR_ibm_sl_api_key="$VALUE"
export TF_VAR_ibm_account_guid="$VALUE"  # If needed
export TF_VAR_ibm_org_guid="$VALUE"  # If needed
export TF_VAR_ibm_space_guid="$VALUE"  # If needed
```

## Examples

- [Log Analysis service deployed and configured on a VSI](LogAnalysisVSI/)
- [Monitoring service deployed and configured on a VSI](MonitoringVSI/)
- [Cloud Object storage deployed and configured to automatically backup VSI](VsiWithCosBackup/)
- [Deploying a Mult-zone Kubernetes cluster](KubernetesMultiZoneCluster/)
- [Deploying a Bare Metal server with RAID](BareMetalServer/)
- [Distributed Minio Cluster fronted by Cloud Load Balancer](LBaaSMinioVSI/)
- and many more... 
