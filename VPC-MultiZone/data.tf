data "ibm_is_zones" "regional_zones" {
  region = var.region
}

data "ibm_is_ssh_key" "key" {
  name = var.ssh_key
}

data "ibm_resource_group" "group" {
  name = var.resource_group
}