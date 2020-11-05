resource "ibm_is_security_group" "bastion_security_group" {
  name           = "bastion-sg"
  vpc            = var.vpc_id
  resource_group = var.resource_group_id
}

resource "ibm_is_security_group_rule" "ssh" {
  group     = ibm_is_security_group.bastion_security_group.id
  direction = "inbound"
  remote    = var.remote_ip
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "vpc_allow_in" {
  count     = length(var.subnets)
  group     = ibm_is_security_group.bastion_security_group.id
  direction = "inbound"
  remote    = var.subnets[count.index]
}

resource "ibm_is_security_group_rule" "egress_all" {
  group     = ibm_is_security_group.bastion_security_group.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}

resource "ibm_is_security_group_rule" "vpn" {
  group     = ibm_is_security_group.bastion_security_group.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  udp {
    port_min = 65000
    port_max = 65000
  }
}

resource "ibm_is_instance" "instance" {
  name           = "${var.name}-bastion"
  vpc            = var.vpc_id
  zone           = var.zone[0]
  resource_group = var.resource_group_id
  profile        = var.profile_name
  image          = data.ibm_is_image.image.id
  keys           = var.ssh_key_ids

  # inject dns config
  user_data = file("${path.module}/init.sh")

  primary_network_interface {
    subnet          = var.subnet_id[0]
    security_groups = [ibm_is_security_group.bastion_security_group.id]
  }

  boot_volume {
    name = "${var.name}-bastion-boot"
  }

  tags = concat(var.tags, ["vpc"])
}

resource "ibm_is_floating_ip" "bastion_ip" {
  name           = "${var.name}-bastion-fip"
  target         = ibm_is_instance.instance.primary_network_interface[0].id
  resource_group = var.resource_group_id
}



