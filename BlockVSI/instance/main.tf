resource ibm_compute_vm_instance blockvsitest {
  hostname          = "blockvsitest"
  os_reference_code = var.os_image
  domain            = var.domain
  datacenter        = var.datacenter
  network_speed     = 1000
  hourly_billing    = true
  flavor_key_name   = var.instance_size
  local_disk        = false
  ssh_key_ids       = [data.ibm_compute_ssh_key.ssh.id]
  block_storage_ids = [var.storage_id]
  tags              = [var.datacenter, "terraform"]
  user_metadata     = templatefile("${path.module}/mount.sh", { sl_username = var.sl_username, sl_api_key = var.sl_apikey, block_id = var.storage_id, target_ip = var.target_ip })
}