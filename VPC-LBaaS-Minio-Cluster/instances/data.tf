data ibm_is_image image {
  name = var.image
}


data "ibm_is_ssh_key" "key" {
  name = var.ssh_key
}

data "ibm_resource_group" "group" {
  name = var.resource_group
}


