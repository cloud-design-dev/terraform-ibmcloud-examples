data "ibm_is_zones" "regional_zones" {
  region = var.region
}

data "ibm_resource_group" "group" {
  name = var.resource_group
}

data ibm_is_image image {
  name = var.image_name
}

data ibm_is_ssh_key key {
  name = var.ssh_key
}