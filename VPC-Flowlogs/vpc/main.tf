resource ibm_is_vpc vpc {
  name                      = "${var.name}-vpc"
  resource_group            = data.ibm_resource_group.group.id
  tags                      = concat(var.tags, ["vpc"])
  address_prefix_management = "auto"
}

resource "ibm_is_public_gateway" "gateway" {
  name           = "${var.name}-gateway"
  vpc            = ibm_is_vpc.vpc.id
  zone           = data.ibm_is_zones.regional_zones.zones[0]
  resource_group = data.ibm_resource_group.group.id
}

resource ibm_is_network_acl network_acl {
  name           = "${var.name}-acl"
  vpc            = ibm_is_vpc.vpc.id
  resource_group = data.ibm_resource_group.group.id

  rules {
    name        = "egress"
    action      = "allow"
    source      = "0.0.0.0/0"
    destination = "0.0.0.0/0"
    direction   = "outbound"
  }
  rules {
    name        = "ingress"
    action      = "allow"
    source      = "0.0.0.0/0"
    destination = "0.0.0.0/0"
    direction   = "inbound"
  }
}

resource ibm_is_subnet subnet {
  name                     = "${var.name}-subnet"
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = data.ibm_is_zones.regional_zones.zones[0]
  resource_group           = data.ibm_resource_group.group.id
  total_ipv4_address_count = 256
  network_acl              = ibm_is_network_acl.network_acl.id
  public_gateway           = ibm_is_public_gateway.gateway.id
}