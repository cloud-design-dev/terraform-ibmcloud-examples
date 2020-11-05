resource random_id name {
  byte_length = 6
}

resource ibm_compute_vm_instance instance {
  hostname          = "windev"
  os_reference_code = var.os_image
  domain            = var.domain
  datacenter        = var.datacenter
  network_speed     = 1000
  hourly_billing    = true
  flavor_key_name   = var.instance_size
  local_disk        = true
  tags              = [var.datacenter, "terraform"]
  user_metadata     = file("${path.module}/cloud-init.ps1")
}

