module vpc {
  source         = "./vpc"
  name           = var.name
  resource_group = var.resource_group
}

module minio_instance {
  source  = "./instances"
  name    = var.name
  zone    = data.ibm_is_zones.regional_zones.zones[0]
  vpc     = module.vpc.id
  ssh_key = var.ssh_key
}


