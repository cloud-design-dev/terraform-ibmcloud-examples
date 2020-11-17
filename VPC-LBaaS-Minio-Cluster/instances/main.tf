resource ibm_is_volume minio_data {
  name           = "minio-volume-${var.name}"
  resource_group = data.ibm_resource_group.group.id
  profile        = "custom"
  zone           = var.zone
  iops           = 1000
  capacity       = 200
  tags           = concat(var.tags, ["minio:data"])
}

resource ibm_is_instance minio {
  name           = "instance-${var.name}"
  vpc            = var.vpc_id
  zone           = var.zone
  resource_group = data.ibm_resource_group.group.id
  profile        = var.profile
  image          = data.ibm_is_image.image.id
  keys           = [data.ibm_is_ssh_key.key.id]

  # inject dns config
  user_data = file("${path.module}/minio_installer.sh")

  primary_network_interface {
    subnet          = var.subnet_id
    security_groups = [var.default_security_group]
  }

  boot_volume {
    name = "${var.name}-${var.zone}-minio-boot"
  }

  volumes = [ibm_is_volume.minio_data.id]

  tags = concat(var.tags, ["minio:instance"])
}
