
data "ibm_compute_ssh_key" "sshkey" {
  label = "ryan_terra"
}
resource "ibm_compute_vm_instance" "node" {
  depends_on           = ["ibm_service_instance.cos"]
  hostname             = "tfnode"
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
    source      = "tfcostest.out"
    destination = "/tmp/tfcostest.coskey"
  }

  provisioner "file" {
    source      = "rsnapshot.conf"
    destination = "/tmp/rsnapshot.conf"
  }

  provisioner "file" {
    source      = "s3cfg"
    destination = "/tmp/s3cfg"
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
    command = "rm -f tfcostest.out"
  }
}
