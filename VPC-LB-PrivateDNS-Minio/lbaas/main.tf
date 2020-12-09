resource ibm_is_lb lb {
  name           = "${var.name}-lb"
  subnets        = [var.subnet_id]
  resource_group = data.ibm_resource_group.group.id
  tags           = concat(var.tags, ["loadbalancer", "project:${var.name}"])
}

resource ibm_is_lb_pool pool {
  name           = "${var.name}-lb-pool"
  lb             = ibm_is_lb.lb.id
  algorithm      = "round_robin"
  protocol       = "http"
  health_delay   = 60
  health_retries = 5
  health_timeout = 30
  health_type    = "http"
}

resource "ibm_is_lb_pool_member" "pool_member" {
  count          = length(var.instances)
  lb             = ibm_is_lb.lb.id
  pool           = ibm_is_lb_pool.pool.id
  port           = 9000
  target_address = element(var.instances[*].primary_network_interface[0].primary_ipv4_address, count.index)
  weight         = 60
}
