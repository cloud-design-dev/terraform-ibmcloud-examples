## IKS Cluster deployed in to a new IBM Cloud VPC
This repository has example code for deploying a new IBM Cloud VPC, Subnets, and an IKS cluster in to the new VPC using Terraform

## CLI Example
```
$ git clone https://github.com/greyhoundforty/IBMCloud-Terraform-Examples.git
$ cd VPC-IKS
$ terraform init 
$ terraform plan -var "resource_group_name=<Resource Group>" -var "region=<Region>" -var "vpc_name=<VPC name>" -var "cluster_name=<Cluster Name>" -out default.tfplan
$ terraform apply default.tfplan
```

## Use with IBM Cloud Schematics
 - Create a new Schematics Workspace > https://cloud.ibm.com/schematics/workspaces/create
 - After the Workspace is created, you will be prompted to supply the following:
   - **Terraform Template Repository:** `https://github.com/greyhoundforty/ibmcloud-iks-new-vpc-schematics`
   - **Terraform Version:**  `terraform_v0.12`
 - Click Save Template information.
 - On the subsequent page fill in the variables [`resource_group_name, region, vpc_name, cluster_name`] and click Save Changes.
 - Click Generate plan.
 - Click Apply plan. 

## Diagram
![Deployment Diagram](images/iks-vpc-diagram.png)
