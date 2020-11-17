resource ibm_dns_zone consul_zone {
  name        = var.zone
  instance_id = var.instance_id
  description = "Consul DNS private zone"
}


resource ibm_dns_permitted_network consul_dns {
  instance_id = var.instance_id
  vpc_crn     = var.vpc_crn
  zone_id     = ibm_dns_zone.consul_zone.zone_id
  type        = "vpc"
}

resource "ibm_dns_resource_record" "instance_record" {
  count       = length(var.instance_ips)
  instance_id = var.instance_id
  zone_id     = ibm_dns_zone.consul_zone.zone_id
  type        = "A"
  name        = "${var.name}-instance${count.index + 1}"
  rdata       = var.instance_ips[count.index]
  ttl         = 3600
}