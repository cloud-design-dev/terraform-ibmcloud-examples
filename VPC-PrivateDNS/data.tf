data "ibm_is_zones" "mzr" {
  region = var.region
}


data "ibm_resource_group" "group" {
  name = var.resource_group
}

data ibm_is_image image {
  name = var.image
}

data ibm_is_ssh_key key {
  name = var.ssh_key
}

data "ibm_resource_instance" "private_dns_instance" {
  name              = "dns-rt"
  location          = "global"
  resource_group_id = data.ibm_resource_group.group.id
  service           = "dns-svcs"
}