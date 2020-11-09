resource ibm_cis cis_instance {
  name              = var.name
  plan              = "trial"
  resource_group_id = data.ibm_resource_group.group.id
  tags              = ["cloud-internet-services"]
  location          = "global"
}

resource ibm_cis_domain domain {
  domain = var.domain
  cis_id = ibm_cis.cis_instance.id
}

resource ibm_cis_origin_pool default_pool {
  cis_id = ibm_cis.cis_instance.id
  name   = "${var.name}-default-pool"
  origins {
    name    = "origin-1"
    address = var.origin_pool_ips[0]
    enabled = var.enabled
  }
  origins {
    name    = "origin-2"
    address = var.origin_pool_ips[1]
    enabled = var.enabled
  }
  description        = "Example default balancer pool"
  enabled            = var.enabled
  minimum_origins    = 1
  notification_email = "someone@example.com"
  check_regions      = ["ENAM"]
}

resource ibm_cis_origin_pool fallback_pool {
  cis_id = ibm_cis.cis_instance.id
  name   = "${var.name}-fallback-pool"
  origins {
    name    = "origin-3"
    address = var.origin_pool_ips[2]
    enabled = var.enabled
  }
  description        = "Example fall back balancer pool"
  enabled            = var.enabled
  minimum_origins    = 1
  notification_email = "someone@example.com"
  check_regions      = ["WNAM"]
}

resource ibm_cis_global_load_balancer lb {
  cis_id           = ibm_cis.cis_instance.id
  domain_id        = ibm_cis_domain.domain.id
  name             = "www.${var.domain}"
  fallback_pool_id = ibm_cis_origin_pool.fallback_pool.id
  default_pool_ids = [ibm_cis_origin_pool.default_pool.id]
  description      = "Example load balancer using geo-balancing"
  proxied          = true
}