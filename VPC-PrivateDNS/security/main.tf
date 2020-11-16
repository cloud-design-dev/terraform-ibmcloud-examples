resource ibm_is_security_group default {
  name           = "${var.name}-default-sg"
  vpc            = var.vpc_id
  resource_group = data.ibm_resource_group.group.id
}

resource ibm_is_security_group_rule ssh {
  group     = ibm_is_security_group.default.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource ibm_is_security_group_rule egress_all {
  group     = ibm_is_security_group.default.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}