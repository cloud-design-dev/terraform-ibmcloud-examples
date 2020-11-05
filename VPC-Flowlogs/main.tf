module object_storage {
  source         = "./object-storage"
  region         = var.region
  resource_group = var.resource_group
  tags           = var.tags
  name           = var.name
}

module vpc {
  source         = "./vpc"
  region         = var.region
  resource_group = var.resource_group
  ssh_key        = var.ssh_key
  tags           = var.tags
  name           = var.name
}

module flowlogs {
  source         = "./flowlogs"
  region         = var.region
  resource_group = var.resource_group
  vpc_id         = module.vpc.id
  cos_id         = module.object_storage.cos_id
  subnet_id      = module.vpc.subnet_id
  vpc_bucket     = module.object_storage.vpc_bucket
  tags           = var.tags
  name           = var.name
  subnet_bucket  = module.object_storage.subnet_bucket
}