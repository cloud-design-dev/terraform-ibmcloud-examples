data "ibm_compute_ssh_key" "sshkey" {
  label = "iodevbox"
}

resource "ibm_compute_vm_instance" "node" {
  depends_on           = ["ibm_service_instance.monitoring"]
  hostname             = "tfmonitor"
  domain               = "${var.domainname}"
  os_reference_code    = "${var.os}"
  datacenter           = "${var.datacenter}"
  network_speed        = 1000
  hourly_billing       = true
  private_network_only = false
  cores                = "${var.vm_cores}"
  memory               = "${var.vm_memory}"
  disks                = [100]
  local_disk           = false
  public_vlan_id       = "${var.pub_vlan}"
  private_vlan_id      = "${var.priv_vlan}"
  ssh_key_ids          = ["${data.ibm_compute_ssh_key.sshkey.id}"]

  provisioner "file" {
    source      = "tfmonitoring.key"
    destination = "/tmp/tfmonitoring.key"
  }

  provisioner "file" {
    source      = "space.id"
    destination = "/tmp/space.id"
  }

  provisioner "file" {
    source      = "postinstall.sh"
    destination = "/tmp/postinstall.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/postinstall.sh",
      "/tmp/postinstall.sh",
    ]
  }

  provisioner "local-exec" {
    command = "rm -f space.id && rm -f tfmonitoring.key"
  }
}
