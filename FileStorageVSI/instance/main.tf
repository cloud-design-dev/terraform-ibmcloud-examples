resource "ibm_compute_vm_instance" "fsvsitest" {
  hostname          = "fsvsitest"
  os_reference_code = var.os_image
  domain            = var.domain
  datacenter        = var.datacenter
  network_speed     = 1000
  hourly_billing    = true
  flavor_key_name   = var.instance_size
  local_disk        = false
  tags              = ["filestorage", "terraform"]
  ssh_key_ids       = [data.ibm_compute_ssh_key.ssh_key.id]
  file_storage_ids  = [var.storage_id]
  user_metadata     = templatefile("${path.module}/mount.sh", { mountpoint = var.mountpoint })
}