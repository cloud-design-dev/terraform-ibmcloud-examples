resource ibm_is_vpc vpc {
  name           = "${var.name}-vpc"
  tags           = concat(var.tags, ["vpc"])
  resource_group = data.ibm_resource_group.group.id
}

resource ibm_is_public_gateway zone_gateway {
  name           = "${var.name}-gateway"
  tags           = ["public-gateway"]
  resource_group = data.ibm_resource_group.group.id
  vpc            = ibm_is_vpc.vpc.id
  zone           = data.ibm_is_zones.regional_zones.zones[0]
}

resource ibm_is_subnet zone_subnet {
  name                     = "${var.name}-subnet"
  resource_group           = data.ibm_resource_group.group.id
  zone                     = data.ibm_is_zones.regional_zones.zones[0]
  public_gateway           = ibm_is_public_gateway.zone_gateway.id
  vpc                      = ibm_is_vpc.vpc.id
  total_ipv4_address_count = 32
}

resource ibm_is_security_group vpc_security_group {
  name           = "${var.name}-security-group"
  vpc            = ibm_is_vpc.vpc.id
  resource_group = data.ibm_resource_group.group.id
}

resource ibm_is_security_group_rule ssh_in {
  group     = ibm_is_security_group.vpc_security_group.id
  direction = "inbound"
  remote    = var.remote_ip
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource ibm_is_security_group_rule icmp_in {
  group     = ibm_is_security_group.vpc_security_group.id
  direction = "inbound"
  remote    = var.remote_ip
  icmp {
    type = 8
  }
}

resource ibm_is_security_group_rule all_out {
  group     = ibm_is_security_group.vpc_security_group.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}

resource ibm_is_ssh_key ssh_key {
  name           = "${var.name}-${var.region}-sshkey"
  public_key     = var.public_key
  resource_group = data.ibm_resource_group.group.id
  tags           = concat(var.tags, ["sshkey"])
}

resource ibm_is_instance instance {
  count          = var.instance_count
  name           = "${var.name}-instance-${count.index + 1}"
  vpc            = ibm_is_vpc.vpc.id
  zone           = data.ibm_is_zones.regional_zones.zones[0]
  resource_group = data.ibm_resource_group.group.id
  profile        = var.profile_name
  image          = data.ibm_is_image.image.id
  keys           = [ibm_is_ssh_key.ssh_key.id]

  primary_network_interface {
    subnet          = ibm_is_subnet.zone_subnet.id
    security_groups = [ibm_is_security_group.vpc_security_group.id]
  }

  boot_volume {
    name = "${var.name}-instance-${count.index + 1}-boot-volume"
  }

  tags = concat(var.tags, ["instance"])
}


resource ibm_is_floating_ip fip {
  name           = "${var.name}-ip"
  target         = ibm_is_instance.instance[0].primary_network_interface[0].id
  resource_group = data.ibm_resource_group.group.id
}