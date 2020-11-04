resource "ibm_is_vpc" "iks_vpc" {
  name           = var.vpc_name
  resource_group = var.resource_group
  tags           = [var.vpc_name]
}