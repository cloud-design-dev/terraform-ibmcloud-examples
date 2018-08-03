
data "ibm_container_cluster_config" "singlezone-rtk8s" {
  org_guid        = "${var.org_guid}"
  space_guid      = "${var.space_guid}"
  account_guid    = "${var.account_guid}"
  cluster_name_id = "${var.cluster}"
  config_dir      = "/Users/ryan/Desktop"
}


resource "ibm_container_worker_pool" "edge_workerpool" {
  worker_pool_name = "edge_worker_pool"
  machine_type     = "u2c.2x4"
  cluster          = "${data.ibm_container_cluster_config.singlezone-rtk8s.id}"
  size_per_zone    = 2
  hardware         = "shared"
  disk_encryption  = "true"

  labels = {
    "test" = "test-pool"
  }

  //User can increase timeouts 
    timeouts {
      update = "180m"
    }
}