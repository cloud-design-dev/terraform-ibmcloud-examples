locals {
  zones = [data.ibm_is_zones.regional_zones.zones[0], data.ibm_is_zones.regional_zones.zones[1], data.ibm_is_zones.regional_zones.zones[2]]
}

module "vpc" {
  source            = "./vpc"
  name              = "${var.basename}-vpc"
  resource_group_id = data.ibm_resource_group.group.id
  tags              = var.tags
  zone              = local.zones
}

module "networking" {
  source            = "./network"
  name              = var.basename
  zone              = local.zones
  vpc               = module.vpc.vpc_id
  resource_group_id = data.ibm_resource_group.group.id
  network_acl       = module.vpc.vpc_default_acl
}

module "security" {
  source            = "./security"
  subnets           = module.networking.cidr
  resource_group_id = data.ibm_resource_group.group.id
  vpc               = module.vpc.vpc_id
}

module "bastion" {
  source            = "./bastion"
  name              = var.basename
  zone              = local.zones
  remote_ip         = var.remote_ip
  vpc_id            = module.vpc.vpc_id
  resource_group_id = data.ibm_resource_group.group.id
  subnet_id         = module.networking.subnet_id
  ssh_key_ids       = [data.ibm_is_ssh_key.key.id]
  tags              = concat(var.tags, ["bastion"])
  subnets           = module.networking.cidr
}

module "instance" {
  source            = "./instance"
  name              = var.basename
  zone              = local.zones
  vpc               = module.vpc.vpc_id
  resource_group_id = data.ibm_resource_group.group.id
  subnet_id         = module.networking.subnet_id
  security_group    = module.security.instance_security_group_id
  ssh_key_ids       = [data.ibm_is_ssh_key.key.id]
  tags              = concat(var.tags, ["instance"])
}