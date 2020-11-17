
module vpc {
  source         = "git::https://github.com/cloud-design-dev/ibm-vpc-module.git"
  name           = var.project_name
  resource_group = var.resource_group
  tags           = var.tags
}

module public_gateway {
  source         = "git::https://github.com/cloud-design-dev/ibm-vpc-public-gateway-module.git"
  name           = var.project_name
  resource_group = var.resource_group
  zone           = var.zones[0]
  vpc_id         = module.vpc.id
}

module subnet {
  source         = "git::https://github.com/cloud-design-dev/ibm-vpc-subnet-count-module.git"
  name           = var.project_name
  resource_group = var.resource_group
  zone           = var.zones[0]
  public_gateway = module.public_gateway.gw_id
  network_acl    = module.vpc.default_network_acl
  vpc_id         = module.vpc.id
  address_count  = var.address_count
}

resource "ibm_is_security_group_rule" "http_in" {
    group = module.vpc.default_security_group
    direction = "inbound"
    remote = module.subnet.ipv4_cidr_block
    tcp {
        port_max = 80
        port_min = 80
    }
}

resource "ibm_is_security_group_rule" "ssh_in" {
    group = module.vpc.default_security_group
    direction = "inbound"
    remote = "0.0.0.0/0"
    tcp {
        port_max = 22
        port_min = 22
    }
}

resource "ibm_is_security_group_rule" "all_outbound" {
    group = module.vpc.default_security_group
    direction = "outbound"
    remote = "0.0.0.0/0"
}