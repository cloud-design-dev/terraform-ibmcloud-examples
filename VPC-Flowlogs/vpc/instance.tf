resource ibm_is_instance instance {
  name           = "${var.name}-instance"
  vpc            = ibm_is_vpc.vpc.id
  zone           = data.ibm_is_zones.regional_zones.zones[0]
  profile        = var.profile_name
  image          = data.ibm_is_image.image.id
  keys           = [data.ibm_is_ssh_key.key.id]
  resource_group = data.ibm_resource_group.group.id

  # inject dns config
  user_data = file("${path.module}/init.sh")

  primary_network_interface {
    subnet          = ibm_is_subnet.subnet.id
    security_groups = [ibm_is_security_group.instance_sg.id]
  }

  boot_volume {
    name = "${var.name}-bastion-boot"
  }

  tags = concat(var.tags, ["bastion"])
}


resource "ibm_is_floating_ip" "instance_ip" {
  name           = "${var.name}-bastion-fip"
  target         = ibm_is_instance.instance.primary_network_interface.0.id
  resource_group = data.ibm_resource_group.group.id
}