resource ibm_storage_block blocktest {
  type              = "Endurance"
  datacenter        = var.datacenter
  capacity          = var.storage_size
  iops              = var.storage_iops
  os_format_type    = "Linux"
  snapshot_capacity = 10
  hourly_billing    = true
}