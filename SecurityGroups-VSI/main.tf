data "ibm_compute_ssh_key" "terra" {
  label = "terra"
}

resource "ibm_security_group" "sgterraform" {
  name        = "sgterraform"
  description = "allow my server traffic"
}

resource "ibm_security_group_rule" "allow_ssh_home" {
  direction         = "ingress"
  ether_type        = "IPv4"
  port_range_min    = 22
  port_range_max    = 22
  protocol          = "tcp"
  remote_ip         = "192.168.0.100"
  security_group_id = ibm_security_group.sgterraform.id
}

resource "ibm_security_group_rule" "allow_ssh_work" {
  direction         = "ingress"
  ether_type        = "IPv4"
  port_range_min    = 22
  port_range_max    = 22
  protocol          = "tcp"
  remote_ip         = "192.168.0.200"
  security_group_id = ibm_security_group.sgterraform.id
}

resource "ibm_security_group_rule" "allow_ssh_jumpbox" {
  direction         = "ingress"
  ether_type        = "IPv4"
  port_range_min    = 22
  port_range_max    = 22
  protocol          = "tcp"
  remote_ip         = "192.168.0.300"
  security_group_id = ibm_security_group.sgterraform.id
}

resource "ibm_compute_vm_instance" "node" {
  hostname             = "sgtest"
  domain               = var.domainname
  os_reference_code    = var.os
  datacenter           = var.datacenter
  network_speed        = 1000
  hourly_billing       = true
  private_network_only = false
  cores                = var.vm_cores
  memory               = var.vm_memory
  disks                = [100]
  local_disk           = false
  private_vlan_id      = var.priv_vlan
  public_vlan_id       = var.pub_vlan
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibility in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  ssh_key_ids               = [data.ibm_compute_ssh_key.sshkey.id]
  public_security_group_ids = [ibm_security_group.sgterraform.id]
}

