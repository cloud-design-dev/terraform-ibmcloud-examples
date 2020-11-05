resource "ibm_compute_bare_metal" "monthly_bm1" {
  package_key_name       = "DUAL_E52600_V4_12_DRIVES"
  process_key_name       = "INTEL_INTEL_XEON_E52620_V4_2_10"
  memory                 = 64
  os_key_name            = var.os_image
  hostname               = "bm-tf-test"
  domain                 = var.domain
  datacenter             = var.datacenter
  network_speed          = 10000
  public_bandwidth       = 500
  disk_key_names         = ["HARD_DRIVE_800GB_SSD", "HARD_DRIVE_800GB_SSD", "HARD_DRIVE_800GB_SSD"]
  hourly_billing         = false
  private_network_only   = false
  unbonded_network       = true
  public_vlan_id         = var.public_vlan_id
  private_vlan_id        = var.private_vlan_id
  tags                   = ["baremetal", var.datacenter]
  redundant_power_supply = true
}

