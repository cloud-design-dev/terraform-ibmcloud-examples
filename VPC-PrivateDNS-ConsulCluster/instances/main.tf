
resource "ibm_is_instance" "instance" {
  name           = var.name
  vpc            = var.vpc
  zone           = var.zone
  profile        = var.profile_name
  image          = data.ibm_is_image.image.id
  keys           = [data.ibm_is_ssh_key.key.id]
  resource_group = var.resource_group

  # inject dns config
  user_data = templatefile("${path.module}/instance-init.sh", { hostname = var.name, consul_version = var.consul_version, encrypt_key = var.encrypt_key, acl_token = var.acl_token, zone = var.zone })

  primary_network_interface {
    subnet          = data.ibm_is_subnet.subnet.id
    security_groups = var.internal_security_group
  }

  network_interfaces {
    name            = "eth1"
    subnet          = data.ibm_is_subnet.subnet.id
    security_groups = var.consul_security_group
  }

  boot_volume {
    name = "${var.name}-${var.zone}-boot"
  }

  tags = concat(var.tags, ["instance", "consul-cluster"])
}