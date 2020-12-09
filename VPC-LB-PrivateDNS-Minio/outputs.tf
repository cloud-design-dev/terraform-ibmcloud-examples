output fip {
  value = module.instances.floating_ip
}

output minio_cluster_ips {
  value = module.instances.instance[*].primary_network_interface[0].primary_ipv4_address
}


