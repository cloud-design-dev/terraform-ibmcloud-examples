data "ibm_is_zones" "mzr" {
  region = var.region
}

data "ibm_resource_group" "group" {
  name = var.resource_group
}