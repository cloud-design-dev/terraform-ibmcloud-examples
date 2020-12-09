resource "ibm_is_security_group_rule" "minio_in_rule_tcp" {
  group     = var.default_security_group
  direction = "inbound"
  remote    = var.subnet
  tcp {
    port_min = 9000
    port_max = 9000
  }
}

resource "ibm_is_security_group_rule" "ssh_in_rule_tcp" {
  group     = var.default_security_group
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "outbound_all" {
  group     = var.default_security_group
  direction = "outbound"
  remote    = "0.0.0.0/0"
}