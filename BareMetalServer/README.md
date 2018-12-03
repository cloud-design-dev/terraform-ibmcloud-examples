## Bare Metal Server

The following example will deploy a montly Bare Metal server to the IBM Cloud using Terraform. 

First copy the template file for our credentials

```
$ cp ../credentials.tfvars.tmpl ../credentials.tfvars
```

Update the `../credentials.tfvars` with your SoftLayer username, API key and your IBM Cloud API Key

```hcl
$ terraform init
$ terraform plan -var-file='../credentials.tfvars' -out bmtest.tfplan
$ terraform apply bmtest.tfplan
```