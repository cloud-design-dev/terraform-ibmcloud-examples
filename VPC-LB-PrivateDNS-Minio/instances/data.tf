data ibm_is_image image {
  name = var.image
}

data "ibm_resource_group" "group" {
  name = var.resource_group
}


