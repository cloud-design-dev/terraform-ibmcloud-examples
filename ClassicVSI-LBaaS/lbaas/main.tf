resource ibm_lbaas lbaas {
  name        = "tflbaas"
  description = "LBaaS spun up using terraform"
  subnets     = [var.subnet_id]

  protocols {
    frontend_protocol     = "HTTP"
    frontend_port         = 80
    backend_protocol      = "HTTP"
    backend_port          = 80
    load_balancing_method = "round_robin"
  }
}

resource ibm_lbaas_server_instance_attachment lbaas_member {
  count              = length(var.instance_ips)
  private_ip_address = element(var.instance_ips, count.index)
  weight             = 40
  lbaas_id           = ibm_lbaas.lbaas.id
  depends_on         = [ibm_lbaas.lbaas]
}