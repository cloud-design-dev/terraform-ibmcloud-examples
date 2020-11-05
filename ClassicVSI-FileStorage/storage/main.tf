resource "ibm_storage_file" "fs_performance" {
  type              = "Performance"
  datacenter        = var.datacenter
  capacity          = var.storage_size
  iops              = var.storage_iops
  snapshot_capacity = 10
  hourly_billing    = true
}