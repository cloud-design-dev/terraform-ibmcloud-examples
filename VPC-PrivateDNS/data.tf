data "ibm_is_zones" "regional_zones" {
  region = var.region
}


data "ibm_resource_group" "group" {
  name = var.resource_group
}

data "ibm_resource_instance" "private_dns_instance" {
  name              = "dns-rt"
  location          = "global"
  resource_group_id = data.ibm_resource_group.group.id
  service           = "dns-svcs"
}