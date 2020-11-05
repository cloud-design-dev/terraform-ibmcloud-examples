resource "ibm_is_public_gateway" "gateway" {
  count          = length(var.zone)
  name           = "${var.name}-gateway-${count.index + 1}"
  vpc            = var.vpc
  zone           = var.zone[count.index]
  resource_group = var.resource_group_id
}

resource ibm_is_subnet subnet {
  count                    = length(var.zone)
  name                     = "${var.name}-subnet-${count.index + 1}"
  vpc                      = var.vpc
  zone                     = var.zone[count.index]
  resource_group           = var.resource_group_id
  total_ipv4_address_count = 32
  network_acl              = var.network_acl
  public_gateway           = ibm_is_public_gateway.gateway[count.index].id
}

