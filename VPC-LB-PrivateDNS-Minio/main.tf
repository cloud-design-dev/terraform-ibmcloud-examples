resource random_id name {
  byte_length = 4
}

resource random_id access_key {
  byte_length = 20
}

resource random_id secret_key {
  byte_length = 24
}

resource tls_private_key ssh {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource ibm_is_ssh_key generated_key {
  name           = "${var.name}-${random_id.name.hex}-sshkey"
  public_key     = tls_private_key.ssh.public_key_openssh
  resource_group = data.ibm_resource_group.group.id
  tags           = concat(var.tags, ["region:${var.region}", "project:${var.name}", "terraform:workspace:${terraform.workspace}"])
}

module vpc {
  source         = "./vpc"
  resource_group = var.resource_group
  name           = var.name
  region         = var.region
}

module instances {
  source                 = "./instances"
  instance_count = var.instance_count
  name                   = var.name
  default_security_group = module.vpc.default_security_group
  resource_group         = var.resource_group
  zone                   = data.ibm_is_zones.mzr.zones[0]
  vpc_id                 = module.vpc.id
  subnet_id              = module.vpc.subnet_id
  tags                   = var.tags
  ssh_key                = ibm_is_ssh_key.generated_key.id
}

module ansible {
  source          = "./ansible"
  instances       = module.instances.instance[*]
  bastion_ip      = module.instances.floating_ip
  region          = var.region
  access_key     = random_id.access_key.hex
  secret_key      = random_id.secret_key.hex
}


resource "local_file" "ssh-key" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "${path.module}/outputs/generated_key_rsa"
  file_permission = "0600"
}
