module vpc {
  source         = "./vpc"
  name           = "${var.project_name}-vpc"
  resource_group = var.resource_group
  tags = [
    "project:${var.project_name}",
    "env:${var.environment}",
    "owner:${var.owner}"
  ]
}

module networking {
  source         = "./network"
  name           = var.project_name
  region         = var.region
  vpc_id         = module.vpc.id
  resource_group = var.resource_group
  network_acl    = module.vpc.vpc_default_acl
}

module "instances" {
  source         = "./instances"
  name           = var.project_name
  region         = var.region
  vpc_id         = module.vpc.id
  resource_group = var.resource_group
  subnet_id      = module.networking.subnet_id
  ssh_key        = var.ssh_key
  bastion_sg     = module.networking.bastion_sg
  instance_sg    = module.networking.instance_sg
  tags = [
    "project:${var.project_name}",
    "env:${var.environment}",
    "owner:${var.owner}"
  ]
}

# module bastion {
#   source            = "./bastion"
#   name              = var.project_name
#   zone              = data.ibm_is_zones.regional_zones.zones
#   vpc_id            = module.vpc.vpc_id
#   resource_group_id = data.ibm_resource_group.group.id
#   subnet_id         = module.networking.subnet_id
#   ssh_key           = var.ssh_key
#   subnets           = module.networking.cidrs
#   tags = [
#     "project:${var.project_name}",
#     "env:${var.environment}",
#     "owner:${var.owner}"
#   ]
# }

