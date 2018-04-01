## Prerequisites  
- [Terraform installed](https://www.terraform.io/intro/getting-started/install.html)
- [IBM Cloud Provider Binary installed](https://github.com/IBM-Cloud/terraform-provider-ibm/releases)
- Your IBM Cloud Org and Space

## Configure Terraform  
Create a `~/.terraformrc` file that points to the Terraform binary. For example if you installed the binary to `/usr/local/bin/terraform-provider-ibm` the `~/.terraformrc` would look like this:

```
providers {
    ibm = "/usr/local/bin/terraform-provider-ibm"
}
```

## Configure Plugin to work with Terraform  
To provide your credentials as environment variables, you can use the following code in your `.tf` file.

```
provider "ibm" {
   bluemix_api_key    = "${var.ibm_bx_api_key}"
   softlayer_username = "${var.ibm_sl_username}"
   softlayer_api_key  = "${var.ibm_sl_api_key}"
}
```

Be sure to also define the following variables in your `.tf` files:

```
variable ibm_bx_api_key {}
variable ibm_sl_username {}
variable ibm_sl_api_key {}
variable ibm_bmx_org {}
variable ibm_bmx_space {}
```

You can then export your credentials in your terminal, where $VALUE is your credential.

```
export TF_VAR_ibm_bx_api_key="$VALUE"
export TF_VAR_ibm_sl_username="$VALUE"
export TF_VAR_ibm_sl_api_key="$VALUE"
export TF_VAR_ibm_bmx_org="$VALUE"
export TF_VAR_ibm_bmx_space="$VALUE"
```

## Examples

- [Log Analysis service deployed and configured on a VSI](LogAnalysisVSI/)
- [Monitoring service deployed and configured on a VSI](MonitoringVSI/README.md)
