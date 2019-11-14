# Initial Configuration

## Prerequisites

* [Terraform installed](https://www.terraform.io/intro/getting-started/install.html)
* [IBM Cloud Provider Binary installed](https://github.com/IBM-Cloud/terraform-provider-ibm/releases)


**NOTE**: The IBM Terraform provider does not currently support Terraform `v0.12`. You will need to install `v0.11.x` until such time as the IBM provider has been updated to support the newer version of Terraform.

## Configure Terraform

If the Terraform plugin directory does not already exist create it and put the downloaded IBM Terraform provider in the newly created directory. 

```
$ mkdir $HOME/.terraform.d/plugins
$ mv $HOME/Downloads/terraform-provider-ibm* $HOME/.terraform.d/plugins/
```

## Configure Plugin to work with Terraform
Most of the examples here are configured to work with your credentials exported as Environment Variables. 

### Static credentials

If you need to use Static credentials you can provide them by adding the `ibmcloud_api_key`, `iaas_classic_username`, and `iaas_classic_api_key` arguments in the IBM Cloud provider block.

```hcl
provider "ibm" {
    ibmcloud_api_key = ""
    iaas_classic_username = ""
    iaas_classic_api_key = ""
}
```

### Environment variables
The recommended approach is to provide your credentials by exporting the `IC_API_KEY`, `IAAS_CLASSIC_USERNAME`, and `IAAS_CLASSIC_API_KEY` environment variables, representing your IBM Cloud platform API key, IBM Cloud Classic Infrastructure (SoftLayer) user name, and IBM Cloud infrastructure API key, respectively.

```
export IC_API_KEY="IBM CLOUD API KEY"
export IAAS_CLASSIC_USERNAME="SOFTLAYER USERNAME"
export IAAS_CLASSIC_API_KEY="SOFTLAYER API KEY"
```

Using Environment variables allows you to use a stripped down `provider.tf` file:

```
provider "ibm" {}
```

You can see the full list of supported provider variables [here](https://ibm-cloud.github.io/tf-ibm-docs/).


## Examples

* [Log Analysis service deployed and configured on a VSI](loganalysisvsi.md)
* [Monitoring service deployed and configured on a VSI](monitoringvsi.md)
* [Cloud Object storage deployed and configured to automatically backup VSI](vsiwithcosbackup.md)
* [Deploying a Mult-zone Kubernetes cluster](https://github.com/greyhoundforty/IBMCloud-Terraform-Examples/tree/bd0a179b9fb3f1dd3af704073a7e869b252dcd67/KubernetesMultiZoneCluster/README.md)
* [Deploying a Bare Metal server with RAID](baremetalserver.md)
* [Distributed Minio Cluster fronted by Cloud Load Balancer](lbaasminiovsi.md)
* and many more... 

