module instances {
  source                  = "./instances"
  count                   = length(data.ibm_is_zones.regional_zones.zones)
  name                    = "${var.project_name}-instance${count.index + 1}"
  resource_group          = data.ibm_resource_group.group.id
  vpc                     = data.ibm_is_vpc.vpc.id
  zone                    = data.ibm_is_zones.regional_zones.zones[count.index]
  internal_security_group = [data.ibm_is_security_group.internal.id]
  consul_security_group   = [data.ibm_is_security_group.consul.id]
  ssh_key                 = var.ssh_key
  subnet                  = "us-south-cde-subnet-zone${count.index + 1}"
  tags                    = var.tags
  acl_token               = var.acl_token
  encrypt_key             = var.encrypt_key
}

module pdns {
  source       = "./private-dns"
  zone         = "cde.consul"
  vpc_crn      = data.ibm_is_vpc.vpc.crn
  instance_id  = var.pdns_instance_id
  instance_ips = module.instances[*].instance_ip
  name         = var.project_name
}