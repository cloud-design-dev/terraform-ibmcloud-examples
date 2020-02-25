# Virtual instance with attached File Storage

This example will deploy a File Storage volume and Ubuntu based VSI. The additional scripts will then authorize/configure the File storage volume for use with your newly created VSI. 

> This example has not been updated to work with Terraform v0.12 and the v1.x of the IBM Cloud Terraform provider. **It's on the list!**

<iframe src="https://giphy.com/embed/gbt9uQ5ZweNkQ" width="480" height="270" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/reaction-jackson-hunt-gbt9uQ5ZweNkQ">via GIPHY</a></p>

#TODO# Add issue to repo

```
Error: Unrecognized block type

  on main.tf line 45, in resource "ibm_compute_vm_instance" "fsvsitest":
  45:   provisioner "remote-exec" {

Blocks of type "provisioner" are not expected in
ibm_compute_vm_instance.fsvsitest.provisioner["file"].
```
