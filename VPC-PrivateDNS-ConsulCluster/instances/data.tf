

data ibm_is_image image {
  name       = var.image_name
  visibility = "private"
}

data ibm_is_ssh_key key {
  name = var.ssh_key
}

data ibm_is_subnet subnet {
  name = var.subnet
}

data ibm_is_security_group dmz {
  name = var.dmz_sg
}

data ibm_is_security_group consul {
  name = var.consul_sg
}