resource ibm_is_volume minio_data {
  count          = var.instance_count
  name           = "minio-data-volume-${var.name}-${count.index + 1}"
  resource_group = data.ibm_resource_group.group.id
  profile        = "custom"
  zone           = var.zone
  iops           = 1000
  capacity       = 200
  tags           = concat(var.tags, ["minio:data"])
}

resource ibm_is_instance bastion {
  name           = "bastion-${var.name}"
  vpc            = var.vpc_id
  zone           = var.zone
  resource_group = data.ibm_resource_group.group.id
  profile        = var.profile
  image          = data.ibm_is_image.image.id
  keys           = [var.ssh_key]

  user_data = file("${path.module}/installer.sh")

  primary_network_interface {
    subnet          = var.subnet_id
    security_groups = [var.default_security_group]
  }

  boot_volume {
    name = "${var.name}-${var.zone}-bastion-boot"
  }


  tags = concat(var.tags, ["bastion"])
}

resource ibm_is_instance minio {
  count          = var.instance_count
  name           = "instance-${var.name}-${count.index + 1}"
  vpc            = var.vpc_id
  zone           = var.zone
  resource_group = data.ibm_resource_group.group.id
  profile        = var.profile
  image          = data.ibm_is_image.image.id
  keys           = [var.ssh_key]
  user_data      = file("${path.module}/minio_installer.sh")

  primary_network_interface {
    subnet          = var.subnet_id
    security_groups = [var.default_security_group]
  }

  boot_volume {
    name = "${var.name}-${var.zone}-minio-boot-${count.index + 1}"
  }

  volumes = [ibm_is_volume.minio_data[count.index].id]

  tags = concat(var.tags, ["minio"])
}

resource "ibm_is_floating_ip" "bastion" {
  name           = "${var.name}-bastion-fip"
  target         = ibm_is_instance.bastion.primary_network_interface[0].id
  resource_group = data.ibm_resource_group.group.id
}