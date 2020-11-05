module storage {
  source     = "./storage"
  datacenter = var.datacenter
}

module instance {
  source     = "./instance"
  datacenter = var.datacenter
  ssh_key    = var.ssh_key
  mountpoint = module.storage.mountpoint
  storage_id = module.storage.id
}


