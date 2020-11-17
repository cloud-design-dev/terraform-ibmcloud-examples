resource ibm_is_security_group minio_sg {
    
}



resource ibm_is_instance instance {
  name = "${var.name}-instance-${count.index +1}"
  vpc            = var.vpc_id
  zone           = var.zone
  resource_group = data.ibm_resource_group.group.id
  profile        = var.profile_name
  image          = data.ibm_is_image.image.id
  keys           = [data.ibm_is_ssh_key.key.id]

  # inject dns config
  user_data = file("${path.module}/minio_installer.sh")

  primary_network_interface {
    subnet          = var.subnet_id[0]
    security_groups = [var.bastion_sg]
  }

  boot_volume {
    name = "${var.name}-instance-${count.index +1}-boot"
  }

  tags = concat(var.tags, ["minio"])
}