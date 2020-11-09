resource ibm_is_instance bastion_instance {
  name           = "${var.name}-${data.ibm_is_zones.regional_zones.zones[0]}-instance"
  vpc            = var.vpc_id
  zone           = data.ibm_is_zones.regional_zones.zones[0]
  resource_group = data.ibm_resource_group.group.id
  profile        = var.profile_name
  image          = data.ibm_is_image.image.id
  keys           = [data.ibm_is_ssh_key.key.id]

  # inject dns config
  user_data = file("${path.module}/bastion-init.sh")

  primary_network_interface {
    subnet          = var.subnet_id[0]
    security_groups = [var.bastion_sg]
  }

  boot_volume {
    name = "${var.name}-${data.ibm_is_zones.regional_zones.zones[0]}-bastion-boot"
  }

  tags = concat(var.tags, ["bastion"])
}

resource ibm_is_instance web_instance {
  count          = length(data.ibm_is_zones.regional_zones.zones)
  name           = "${var.name}-webserver-${count.index + 1}"
  vpc            = var.vpc_id
  zone           = data.ibm_is_zones.regional_zones.zones[count.index]
  resource_group = data.ibm_resource_group.group.id
  profile        = var.profile_name
  image          = data.ibm_is_image.image.id
  keys           = [data.ibm_is_ssh_key.key.id]

  # inject dns config
  user_data = file("${path.module}/web-init.sh")

  primary_network_interface {
    subnet          = var.subnet_id[count.index]
    security_groups = [var.instance_sg]
  }

  boot_volume {
    name = "${var.name}-webserver-${count.index + 1}-boot"
  }

  tags = concat(var.tags, ["webserver"])
}

resource "ibm_is_floating_ip" "bastion_ip" {
  name           = "${var.name}-bastion-fip"
  target         = ibm_is_instance.bastion_instance.primary_network_interface[0].id
  resource_group = data.ibm_resource_group.group.id
}