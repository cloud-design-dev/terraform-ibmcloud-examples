resource ibm_security_group custom_security_group {
  name        = "my-custom-sg"
  description = "Allow SSH in from a single IP"
}

resource "ibm_security_group_rule" "allow_remote_ssh" {
  direction         = "ingress"
  ether_type        = "IPv4"
  port_range_min    = 22
  port_range_max    = 22
  protocol          = "tcp"
  remote_ip         = var.remote_ip
  security_group_id = ibm_security_group.custom_security_group.id
}

resource "ibm_compute_vm_instance" "node" {
  hostname                   = "sgtest"
  domain                     = var.domain
  os_reference_code          = var.os_image
  datacenter                 = var.datacenter
  network_speed              = 1000
  hourly_billing             = true
  private_network_only       = false
  local_disk                 = true
  ssh_key_ids                = [data.ibm_compute_ssh_key.sshkey.id]
  public_security_group_ids  = [ibm_security_group.custom_security_group.id, data.ibm_security_group.allow_outbound.id, data.ibm_security_group.allow_http.id]
  private_security_group_ids = [data.ibm_security_group.allow_outbound.id, data.ibm_security_group.allow_ssh.id]
}

