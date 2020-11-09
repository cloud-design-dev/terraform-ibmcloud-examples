# Monitoring a Classic IaaS server with LogDNA 
This example will deploy a trial instance of [Cloud Internet Services](https://cloud.ibm.com/docs/cis?topic=cis-about-ibm-cloud-internet-services-cis), define a domain within CIS and then set up some [Origin Pools](https://cloud.ibm.com/docs/cis?topic=cis-configure-glb#add-a-pool) and a [Global Load balancer](https://cloud.ibm.com/docs/cis?topic=cis-global-load-balancer-glb-concepts) pointing to the origin pools. 

> This code is written to work with Terraform 0.13 and above. If you would like to work with multiple versions of Terraform on the same machine take a look at [tfswitch](https://github.com/warrensbox/terraform-switcher).

**Note:** 
 - The domain you specify in the `terraform.tfvars.example` has to be a registered address. 
 - If you would like to test the Global load balancer you will want to update the `variables.tf` with some real origin IPs. 
 - Only one instance of the trial plan can be deployed per account. 

## To use this code
**Step 1: Clone repo**

```shell
$ git clone https://github.com/greyhoundforty/IBMCloud-Terraform-Examples.git
$ cd Cloud-Internet-Services
```

**Step 2: Update example `.tfvars` file**
You will need to update the `terraform.tfvars.example` and then rename it so that Terraform picks up the variables. The file has comments for each item that you need to provide. When done updating the file rename it:

```shell
$ cp terraform.tfvars.example terraform.tfvars
```

**Step 3: Initialize Terraform**
The `version.tf` file will automatically download the most up to date version of the IBM Cloud Terraform Provider when you initialize the directory.

```shell
$ terraform init
```

**Step 4: Create Terraform plan**
If the `terraform init` command completed without error you are now ready to create a plan for your deployment.

```shell
$ terraform plan -out default.tfplan
```

**Step 5: Apply generated plan**
If our plan generated successfully we can now deploy our resources using the `apply` command.

```shell
$ terraform apply default.tfplan
```