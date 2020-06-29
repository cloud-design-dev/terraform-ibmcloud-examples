provider "ibm" {
  generation = 2
}

resource "ibm_container_vpc_cluster" "vpc_cluster" {
  name              = var.cluster_name
  vpc_id            = var.vpc_id
  flavor            = var.flavor
  worker_count      = 3
  resource_group_id = var.resource_group
  wait_till         = "MasterNodeReady"

  zones {
    subnet_id = var.iks_subnets[0]
    name      = var.zones[0]
  }
  zones {
    subnet_id = var.iks_subnets[1]
    name      = var.zones[1]
  }
  zones {
    subnet_id = var.iks_subnets[2]
    name      = var.zones[2]
  }


}



