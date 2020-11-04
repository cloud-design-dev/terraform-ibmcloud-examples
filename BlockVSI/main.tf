module storage {
  source     = "./storage"
  datacenter = var.datacenter
}

module instance {
  source      = "./instance"
  datacenter  = var.datacenter
  ssh_key     = var.ssh_key
  storage_id  = module.storage.id
  sl_username = var.iaas_classic_username
  sl_apikey   = var.iaas_classic_api_key
  target_ip   = module.storage.target_ip
}