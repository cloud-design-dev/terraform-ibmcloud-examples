module vpc {
  source         = "git::https://github.com/cloud-design-dev/ibm-vpc-module.git"
  name           = var.name
  resource_group = var.resource_group
}

module public_gateway {
  source         = "git::https://github.com/cloud-design-dev/ibm-vpc-public-gateway-module.git"
  name           = var.name
  resource_group = var.resource_group
  vpc_id         = module.vpc.id
  zone           = data.ibm_is_zones.mzr.zones[0]
}

module subnet {
  source         = "git::https://github.com/cloud-design-dev/ibm-vpc-subnet-count-module.git"
  name           = var.name
  resource_group = var.resource_group
  network_acl    = module.vpc.default_network_acl
  address_count  = "32"
  vpc_id         = module.vpc.id
  zone           = data.ibm_is_zones.mzr.zones[0]
  public_gateway = module.public_gateway.id
}

module security {
  source                 = "./security"
  default_security_group = module.vpc.default_security_group
  subnet                 = module.subnet.ipv4_cidr_block
}

module minio {
  source                 = "./instances"
  count                  = 3
  name                   = "${var.name}-${count.index + 1}"
  default_security_group = module.vpc.default_security_group
  resource_group         = var.resource_group
  zone                   = data.ibm_is_zones.mzr.zones[0]
  vpc_id                 = module.vpc.id
  subnet_id              = module.subnet.id
  tags                   = var.tags
  ssh_key                = var.ssh_key
}

resource "ibm_is_floating_ip" "bastion_ip" {
  name           = "${var.name}-bastion-fip"
  target         = module.minio[0].primary_network_interface
  resource_group = data.ibm_resource_group.group.id
}