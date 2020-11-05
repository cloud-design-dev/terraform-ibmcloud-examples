resource ibm_compute_vm_instance instance {
  hostname             = "tflogdnatest"
  domain               = var.domain
  os_reference_code    = var.os_image
  datacenter           = var.datacenter
  network_speed        = 1000
  hourly_billing       = true
  private_network_only = false
  local_disk           = true
  flavor_key_name      = var.instance_size
  user_metadata        = templatefile("${path.module}/install.sh", { ingestion_key = var.ingestion_key, region = var.region })
  ssh_key_ids          = [data.ibm_compute_ssh_key.ssh_key.id]
}