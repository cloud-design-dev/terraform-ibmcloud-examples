# Bare Metal Server
The following example will deploy a montly Bare Metal server to the IBM Cloud using Terraform.

## Export Environmental Variables
In order to use this example you will need to export your Classic IaaS (SoftLayer) username and Classic IaaS (SoftLayer) API Key. 

```shell
export IAAS_USERNAME=<Classic IaaS Username>
export IAAS_APIKEY=<Classic IaaS API Key>
```

## Plan and Apply
Once you've got the variables set, you will need to initiate the repository and run the `plan` and `apply` commands:

```shell
$ terraform init

$ terraform plan -var "iaas_classic_username=${IAAS_USERNAME}" -var "IAAS_APIKEY=${IAAS_APIKEY}" -var "public_vlan_id=<Public VLAN ID>" -var "private_vlan_id=<Private VLAN ID>" -out default.tfplan

$ terraform apply default.tfplan
```

