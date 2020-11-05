resource ibm_compute_vm_instance instance {
  count                      = var.instance_count
  hostname                   = "web-${count.index + 1}"
  domain                     = var.domain
  os_reference_code          = var.os_image
  datacenter                 = var.datacenter
  flavor_key_name            = var.instance_size
  network_speed              = 1000
  hourly_billing             = true
  private_network_only       = true
  local_disk                 = true
  ssh_key_ids                = [data.ibm_compute_ssh_key.ssh_key.id]
  tags                       = ["terraform", "web-servers"]
  user_metadata              = file("${path.module}/install.sh")
  private_security_group_ids = [data.ibm_security_group.allow_http.id, data.ibm_security_group.allow_outbound.id, data.ibm_security_group.allow_ssh.id]
}