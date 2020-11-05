resource "ibm_is_security_group" "instance_sg" {
  name           = "instance-sg"
  vpc            = var.vpc
  resource_group = var.resource_group_id
}

resource "ibm_is_security_group_rule" "ping" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  icmp {
    type = 8
  }
}

resource "ibm_is_security_group_rule" "vpc_allow_in" {
  count     = length(var.subnets)
  group     = ibm_is_security_group.instance_sg.id
  direction = "inbound"
  remote    = var.subnets[count.index]
}

# from https://cloud.ibm.com/docs/vpc?topic=vpc-service-endpoints-for-vpc
resource "ibm_is_security_group_rule" "cse_dns_1" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "outbound"
  remote    = "161.26.0.10"
  udp {
    port_min = 53
    port_max = 53
  }
}

resource "ibm_is_security_group_rule" "cse_dns_2" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "outbound"
  remote    = "161.26.0.11"
  udp {
    port_min = 53
    port_max = 53
  }
}

resource "ibm_is_security_group_rule" "private_dns_1" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "outbound"
  remote    = "161.26.0.7"
  udp {
    port_min = 53
    port_max = 53
  }
}

resource "ibm_is_security_group_rule" "private_dns_2" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "outbound"
  remote    = "161.26.0.8"
  udp {
    port_min = 53
    port_max = 53
  }
}

resource "ibm_is_security_group_rule" "http_out" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 80
    port_max = 80
  }
}

resource "ibm_is_security_group_rule" "https_out" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 443
    port_max = 443
  }
}