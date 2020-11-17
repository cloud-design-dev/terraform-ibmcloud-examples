
resource "ibm_is_instance" "instance" {
  name           = var.name
  vpc            = var.vpc
  zone           = var.zone
  profile        = var.profile_name
  image          = data.ibm_is_image.image.id
  keys           = [data.ibm_is_ssh_key.key.id]
  resource_group = var.resource_group

  # inject dns config
  user_data = templatefile("${path.module}/instance-init.sh", {hostname = var.name})

  primary_network_interface {
    subnet          = data.ibm_is_subnet.subnet.id
    security_groups = [data.ibm_is_security_group.consul.id, data.ibm_is_security_group.dmz.id]
  }

  boot_volume {
    name = "${var.name}-${var.zone}-boot"
  }

  tags = concat(var.tags, ["instance", "consul-cluster"])
}