# Private DNS in IBM Cloud VPC
This example will deploy a new IBM Cloud [VPC](https://cloud.ibm.com/docs/vpc?topic=vpc-about-vpc), 2 small compute instances running Apache, and an instance of the [Private DNS](https://cloud.ibm.com/docs/dns-svcs?topic=dns-svcs-about-dns-services) service. Additionally it will:
 - Create a Floating IP so you can connect and test the DNS resolution 
 - Create A records for both compute instances 
 - Permit the VPC network to query the Private DNS zone 
 - Generate a temporary SSH key to be used to connect to the instances

> This code is written to work with Terraform 0.13 and above. If you would like to work with multiple versions of Terraform on the same machine take a look at [tfswitch](https://github.com/warrensbox/terraform-switcher).

## To use this code
**Step 1: Clone repo**

```shell
$ git clone https://github.com/greyhoundforty/IBMCloud-Terraform-Examples.git
$ cd VPC-PrivateDNS
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

You should now see the Floating IP as well as the DNS records in the Terraform output. We will use these to connect to our bastion instance and curl our webserver via the Private DNS record.

### Connecting to an instance
Use the generated SSH key to connect to the instance with the [Floating IP](https://cloud.ibm.com/docs/vpc?topic=vpc-about-networking-for-vpc#floating-ip-for-external-connectivity) assigned. 

```shell
$ ssh -i generated_key_rsa root@x.x.x.x
```

### Example 
```shell 
$ ssh -i generated_key_rsa root@x.x.x.x

Welcome to Ubuntu 20.04.1 LTS (GNU/Linux 5.4.0-1028-kvm x86_64)
Last login: Thu Dec  3 15:31:57 2020 

root@pdnsv2-instance-1:~# curl -I pdnsv2-instance-1.vpc-cde.local
HTTP/1.1 200 OK
Date: Thu, 03 Dec 2020 15:52:19 GMT
Server: Apache/2.4.41 (Ubuntu)
Last-Modified: Thu, 03 Dec 2020 14:35:45 GMT
ETag: "2aa6-5b590467ad9f4"
Accept-Ranges: bytes
Content-Length: 10918
Vary: Accept-Encoding
Content-Type: text/html
```