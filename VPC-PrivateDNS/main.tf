resource "ibm_is_vpc" "vpc" {
  name           = var.project_name
  resource_group = data.ibm_resource_group.group.id
  tags           = concat(var.tags, ["vpc"])
}

resource ibm_is_public_gateway gateway {
  name           = "${var.project_name}-gateway"
  vpc            = ibm_is_vpc.vpc.id
  zone           = data.ibm_is_zones.mzr.zones[0]
  resource_group = data.ibm_resource_group.group.id
}


resource ibm_is_subnet subnet {
  name                     = "${var.project_name}-subnet"
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = data.ibm_is_zones.mzr.zones[0]
  total_ipv4_address_count = var.address_count
  network_acl              = ibm_is_vpc.vpc.default_network_acl
  public_gateway           = ibm_is_public_gateway.gateway.id
  resource_group           = data.ibm_resource_group.group.id
}

resource ibm_is_security_group_rule ssh_in {
  group     = ibm_is_vpc.vpc.default_security_group
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource ibm_is_security_group_rule http_in {
  group     = ibm_is_vpc.vpc.default_security_group
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 22
    port_max = 22
  }
}


resource ibm_is_security_group_rule all_out {
  group     = ibm_is_vpc.vpc.default_security_group
  direction = "outbound"
  remote    = "0.0.0.0/0"
}

resource "ibm_is_instance" "instance" {
  count          = 2
  name           = "${var.project_name}-instance-${count.index + 1}"
  vpc            = ibm_is_vpc.vpc.id
  zone           = data.ibm_is_zones.mzr.zones[0]
  profile        = var.profile
  image          = data.ibm_is_image.image.id
  keys           = [data.ibm_is_ssh_key.key.id]
  resource_group = data.ibm_resource_group.group.id

  # inject dns config
  user_data = file("${path.module}/instance-init.sh")

  primary_network_interface {
    subnet          = ibm_is_subnet.subnet.id
    security_groups = [ibm_is_vpc.vpc.default_security_group]
  }

  boot_volume {
    name = "${var.project_name}-instance-${count.index + 1}-boot"
  }

  tags = concat(var.tags, ["instance"])
}


resource "ibm_is_floating_ip" "ip" {
  name           = "${var.project_name}-bastion-fip"
  target         = ibm_is_instance.instance[0].primary_network_interface[0].id
  resource_group = data.ibm_resource_group.group.id
}

resource "ibm_dns_zone" "zone" {
    name = var.domain
    instance_id = data.ibm_resource_instance.private_dns_instance.id 
    description = "Private DNS Zone for VPC DNS communication."
    label = "testlabel"
}

resource "ibm_dns_permitted_network" "permitted_network" {
    instance_id = data.ibm_resource_instance.private_dns_instance.id
    zone_id = ibm_dns_zone.zone.zone_id
    vpc_crn = ibm_is_vpc.vpc.crn
    type = "vpc"
}

resource "ibm_dns_resource_record" "a_records" {
  count = var.instance_count
  instance_id = data.ibm_resource_instance.private_dns_instance.id
  zone_id     = ibm_dns_zone.zone.zone_id
  type        = "A"
  name        = "${var.project_name}-instance-${count.index + 1}"
  rdata       = element(ibm_is_instance.instance[*].primary_network_interface[0].primary_ipv4_address, count.index)
  ttl         = 3600
}