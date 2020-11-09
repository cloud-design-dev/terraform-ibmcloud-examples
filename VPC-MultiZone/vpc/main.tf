resource ibm_is_vpc vpc {
  name                      = var.name
  resource_group            = data.ibm_resource_group.group.id
  address_prefix_management = "auto"
  tags                      = concat(var.tags, ["vpc"])
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