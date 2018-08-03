resource "ibm_container_cluster" "rttest_cluster" {
  name            = "rt-tf-test-cluster"
  datacenter      = "wdc06"
  machine_type    = "u2c.2x4"
  public_vlan_id  = "1669321"
  private_vlan_id = "1669323"
  worker_num      = 3
  hardware        = "shared"
  account_guid    = "${var.ibm_account_guid}"
  org_guid        = "${var.ibm_org_guid}"
  space_guid      = "${var.ibm_space_guid}"
}

resource "ibm_container_worker_pool_zone_attachment" "new_zone" {
  depends_on = ["ibm_container_cluster.rttest_cluster"]
  count = 2
  cluster = "rt-tf-test-cluster"
  worker_pool = "default"
  zone = "${element(var.zones,count.index)}"
  private_vlan_id = "${element(var.private_vlans,count.index)}"
  public_vlan_id = "${element(var.public_vlans,count.index)}"
}

