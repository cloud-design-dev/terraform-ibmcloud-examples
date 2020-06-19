# Ordering a VSI with Block storage

The following example will spin up an Ubuntu VSI, order block storage and then configure the OS to mount the block storage volume. If you are running an OS other than Ubuntu you will need to modify the `mount.sh` file to match the specifc commands for your OS. See [Connection to MPIO on Linux](https://cloud.ibm.com/docs/infrastructure/BlockStorage/accessing_block_storage_linux.html#connecting-to-mpio-iscsi-luns-on-linux)

First copy the template file for our credentials

```text
$ cp ../credentials.tfvars.tmpl ../credentials.tfvars
```

Update the `../credentials.tfvars` with your SoftLayer username, API key and your IBM Cloud API Key. Once that is complete you can run `terraform init` to make sure everything is configured properly.

```text
$ terraform init
$ terraform plan -var-file='../credentials.tfvars' -out block.tfplan
$ terraform apply block.tfplan
```

