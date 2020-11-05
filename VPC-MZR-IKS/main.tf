module "vpc" {
  source         = "./01_vpc"
  resource_group = data.ibm_resource_group.default.id
  vpc_name       = var.vpc_name
}

module "networking" {
  source         = "./02_networking"
  resource_group = data.ibm_resource_group.default.id
  vpc_id         = module.vpc.id
  zones          = data.ibm_is_zones.default.zones
  vpc            = module.vpc.name
}

module "iks" {
  source         = "./03_iks"
  vpc_id         = module.vpc.id
  iks_subnets    = module.networking.zone_subnet_ids
  resource_group = data.ibm_resource_group.default.id
  zones          = data.ibm_is_zones.default.zones
  cluster_name   = var.cluster_name
}