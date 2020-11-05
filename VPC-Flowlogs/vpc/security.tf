resource "ibm_is_security_group" "instance_sg" {
  name           = "${var.name}-sg"
  vpc            = ibm_is_vpc.vpc.id
  resource_group = data.ibm_resource_group.group.id
}

resource "ibm_is_security_group_rule" "ping" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  icmp {
    type = 8
    code = 0
  }
}

resource "ibm_is_security_group_rule" "ssh_in" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_max = 22
    port_min = 22
  }
}

resource "ibm_is_security_group_rule" "vpc_allow_in" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "inbound"
  remote    = ibm_is_subnet.subnet.ipv4_cidr_block
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