resource "random_id" "name" {
  byte_length = 4
}

resource "ibm_container_cluster" "multizone_iks" {
  name              = "mzr-${random_id.name.hex}-iks"
  datacenter        = "${var.datacenter["us-south3"]}"
  machine_type      = "${var.vm_flavor["large"]}"
  hardware          = "shared"
  public_vlan_id    = "${var.pub_vlan["us-south3"]}"
  private_vlan_id   = "${var.priv_vlan["us-south3"]}"
  default_pool_size = 3
  account_guid      = "${var.ibm_account_guid}"
  region            = "us-south"
  resource_group_id = "${var.ibm_resource_group_id}"
  kube_version      = "1.12.4"
}

resource "ibm_container_worker_pool" "edge_worker_pool" {
  depends_on       = ["ibm_container_cluster.multizone_iks"]
  worker_pool_name = "edge_worker_pool"
  machine_type     = "${var.vm_flavor["small"]}"
  cluster          = "${ibm_container_cluster.multizone_iks.name}"
  size_per_zone    = 2
  hardware         = "shared"
  disk_encryption  = "true"
  region           = "us-south"
}

resource "ibm_container_worker_pool_zone_attachment" "us_south1_zone" {
  depends_on      = ["ibm_container_worker_pool.edge_worker_pool"]
  cluster         = "${ibm_container_cluster.multizone_iks.name}"
  worker_pool     = "${element(split("/",ibm_container_worker_pool.edge_worker_pool.id),1)}"
  zone            = "${var.us_south_zones["us-south1"]}"
  public_vlan_id  = "${var.pub_vlan["us-south1"]}"
  private_vlan_id = "${var.priv_vlan["us-south1"]}"
  region          = "us-south"
}

resource "ibm_container_worker_pool_zone_attachment" "us_south2_zone" {
  depends_on      = ["ibm_container_worker_pool_zone_attachment.us_south1_zone"]
  cluster         = "${ibm_container_cluster.multizone_iks.name}"
  worker_pool     = "${element(split("/",ibm_container_worker_pool.edge_worker_pool.id),1)}"
  zone            = "${var.us_south_zones["us-south2"]}"
  public_vlan_id  = "${var.pub_vlan["us-south2"]}"
  private_vlan_id = "${var.priv_vlan["us-south2"]}"
  region          = "us-south"
}

resource "ibm_container_worker_pool_zone_attachment" "us_south3_zone" {
  depends_on      = ["ibm_container_worker_pool_zone_attachment.us_south2_zone"]
  cluster         = "${ibm_container_cluster.multizone_iks.name}"
  worker_pool     = "${element(split("/",ibm_container_worker_pool.edge_worker_pool.id),1)}"
  zone            = "${var.us_south_zones["us-south3"]}"
  public_vlan_id  = "${var.pub_vlan["us-south3"]}"
  private_vlan_id = "${var.priv_vlan["us-south3"]}"
  region          = "us-south"
}

