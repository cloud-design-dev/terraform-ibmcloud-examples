module vpc {
  source         = "git::https://github.com/cloud-design-dev/ibm-vpc-module.git"
  name           = var.project_name
  resource_group = var.resource_group
  tags           = var.tags
}

## Defaults to first zone in region.
module public_gateway {
  source         = "git::https://github.com/cloud-design-dev/ibm-vpc-public-gateway-module.git"
  name           = var.project_name
  resource_group = var.resource_group
  zone           = data.ibm_is_zones.mzr.zones[0]
  vpc_id         = module.vpc.id
}


## Defaults to first zone in region. 
module subnet {
  source         = "git::https://github.com/cloud-design-dev/ibm-vpc-subnet-count-module.git"
  name           = var.project_name
  resource_group = var.resource_group
  zone           = data.ibm_is_zones.mzr.zones[0]
  public_gateway = module.public_gateway.gw_id
  network_acl    = module.vpc.default_network_acl
  vpc_id         = module.vpc.id
  address_count  = var.address_count
}

module security {
  source         = "./security"
  name           = var.project_name
  resource_group = var.resource_group
  vpc_id         = module.vpc.id
}

# If you need to use a different OS, set the image_name variable. The default in the module is Ubuntu20 
module instance {
  source            = "git::https://github.com/cloud-design-dev/ibm-vpc-instance-module.git"
  count             = var.instance_count
  name              = var.project_name
  resource_group    = var.resource_group
  zone              = data.ibm_is_zones.mzr.zones[0]
  tags              = var.tags
  vpc_id            = module.vpc.id
  security_group_id = module.security.id
  subnet_id         = module.subnet.id
  ssh_key           = var.ssh_key
}



resource "ibm_dns_zone" "zone" {
    name = var.zone
    instance_id = data.ibm_resource_instance.private_dns_instance.id 
    description = "Private DNS Zone for VPC DNS communication."
    label = "testlabel"
}