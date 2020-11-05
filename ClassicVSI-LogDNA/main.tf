module logdna {
  source         = "./logdna"
  region         = var.region
  resource_group = var.resource_group
}

module instance {
  source        = "./instance"
  datacenter    = var.datacenter
  ssh_key       = var.ssh_key
  ingestion_key = module.logdna.logdna_ingestion_key
  region        = var.region
}