module instance {
  source     = "./instance"
  datacenter = var.datacenter
  ssh_key    = var.ssh_key
}

module lbaas {
  source       = "./lbaas"
  subnet_id    = module.instance.subnet_id
  instance_ips = module.instance.ips
}


