output lbaas_hostname {
  value = ibm_lbaas.lbaas.vip
}

output health_monitors {
  value = ibm_lbaas.lbaas.health_monitors
}