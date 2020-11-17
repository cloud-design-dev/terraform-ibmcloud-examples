module environment {
  source         = "./vpc"
  name           = var.project_name
  resource_group = var.resource_group
  tags           = var.tags
  zones          = data.ibm_is_zones.mzr.zones
}

module instance {
  source            = "git::https://github.com/cloud-design-dev/ibm-vpc-instance-module.git"
  count             = var.instance_count
  name              = var.project_name
  resource_group    = var.resource_group
  zone              = data.ibm_is_zones.mzr.zones[0]
  tags              = var.tags
  vpc_id            = module.environment.vpc_id
  security_group_id = module.environment.sg_id
  subnet_id         = module.environment.subnet_id
  ssh_key           = var.ssh_key
}



resource "ibm_dns_zone" "zone" {
    name = var.domain
    instance_id = data.ibm_resource_instance.private_dns_instance.id 
    description = "Private DNS Zone for VPC DNS communication."
    label = "testlabel"
}