output web_server_private_ips {
  value = module.instance.ips
}

output lbaas_subnet {
  value = module.instance.subnet_id
}

output lbaas_hostname {
  value = module.lbaas.lbaas_hostname
}

output health_monitors {
  value = module.lbaas.health_monitors
}