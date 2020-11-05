resource "ibm_is_instance" "instance" {
  count          = length(var.zone)
  name           = "${var.name}-instance-z${count.index + 1}"
  vpc            = var.vpc
  zone           = var.zone[count.index]
  resource_group = var.resource_group_id
  profile        = var.profile_name
  image          = data.ibm_is_image.image.id
  keys           = var.ssh_key_ids

  # inject dns config
  user_data = file("${path.module}/init.sh")

  primary_network_interface {
    subnet          = var.subnet_id[count.index]
    security_groups = [var.security_group]
  }

  boot_volume {
    name = "${var.name}-boot-${count.index + 1}"
  }

  tags = concat(var.tags, ["vpc"])
}

