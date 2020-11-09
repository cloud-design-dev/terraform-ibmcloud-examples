resource ibm_is_public_gateway gateway {
  count          = length(data.ibm_is_zones.regional_zones.zones)
  name           = "${var.name}-gateway-zone-${count.index + 1}"
  vpc            = var.vpc_id
  zone           = data.ibm_is_zones.regional_zones.zones[count.index]
  resource_group = data.ibm_resource_group.group.id
}

resource ibm_is_subnet subnet {
  count                    = length(data.ibm_is_zones.regional_zones.zones)
  name                     = "${var.name}-subnet-zone-${count.index + 1}"
  vpc                      = var.vpc_id
  zone                     = data.ibm_is_zones.regional_zones.zones[count.index]
  resource_group           = data.ibm_resource_group.group.id
  total_ipv4_address_count = 256
  network_acl              = var.network_acl
  public_gateway           = ibm_is_public_gateway.gateway[count.index].id
}

resource "ibm_is_security_group" "instance_sg" {
  name           = "${var.name}-instance-sg"
  vpc            = var.vpc_id
  resource_group = data.ibm_resource_group.group.id
}

resource "ibm_is_security_group_rule" "ping" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  icmp {
    type = 8
  }
}

resource "ibm_is_security_group_rule" "instance_vpc_allow_in" {
  count     = length(data.ibm_is_zones.regional_zones.zones)
  group     = ibm_is_security_group.instance_sg.id
  direction = "inbound"
  remote    = ibm_is_subnet.subnet[count.index].ipv4_cidr_block
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

resource "ibm_is_security_group_rule" "http_in" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 80
    port_max = 80
  }
}

resource "ibm_is_security_group_rule" "https_in" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 443
    port_max = 443
  }
}

resource "ibm_is_security_group" "bastion_sg" {
  name           = "${var.name}-bastion-sg"
  vpc            = var.vpc_id
  resource_group = data.ibm_resource_group.group.id
}

resource "ibm_is_security_group_rule" "ssh" {
  group     = ibm_is_security_group.bastion_sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "bastion_vpc_allow_in" {
  count     = length(data.ibm_is_zones.regional_zones.zones)
  group     = ibm_is_security_group.bastion_sg.id
  direction = "inbound"
  remote    = ibm_is_subnet.subnet[count.index].ipv4_cidr_block
}

resource "ibm_is_security_group_rule" "bastion_egress_all" {
  group     = ibm_is_security_group.bastion_sg.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}