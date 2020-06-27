data "ibm_compute_ssh_key" "ssh" {
  label = var.ssh_key
}

resource "ibm_storage_block" "blocktest" {
  depends_on                = [ibm_compute_vm_instance.blockvsitest]
  type                      = "Endurance"
  datacenter                = var.datacenter
  capacity                  = var.storage_size
  iops                      = var.storage_iops
  os_format_type            = "Linux"
  snapshot_capacity         = 10
  hourly_billing            = true
  allowed_virtual_guest_ids = [ibm_compute_vm_instance.blockvsitest.id]

  provisioner "local-exec" {
    command = "echo ${jsonencode(ibm_storage_block.blocktest.allowed_host_info)} >> ${ibm_storage_block.blocktest.id}_details.txt"
  }

  provisioner "local-exec" {
    command = "echo Target IP = ${ibm_storage_block.blocktest.hostname} >> ${ibm_storage_block.blocktest.id}_details.txt"
  }
}

resource "ibm_compute_vm_instance" "blockvsitest" {
  hostname          = "blockvsitest"
  os_reference_code = var.os_image
  domain            = var.domain
  datacenter        = var.datacenter
  network_speed     = 1000
  hourly_billing    = true
  flavor_key_name   = var.instance_size
  local_disk        = false
  ssh_key_ids       = [data.ibm_compute_ssh_key.ssh.id]
  tags              = [var.datacenter, "tag2"]
}

resource "null_resource" "vsi_postinstall" {
  depends_on = [ibm_compute_vm_instance.blockvsitest]

  connection {
    type        = "ssh"
    user        = "root"
    host        = ibm_compute_vm_instance.blockvsitest.ipv4_address
    private_key = file("~/.ssh/id_rsa")
  }

  provisioner "file" {
    source      = "mount.sh"
    destination = "/tmp/mount.sh"
  }

  provisioner "file" {
    source      = "${ibm_storage_block.blocktest.id}_details.txt"
    destination = "/tmp/mountpath.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/mount.sh",
      "/tmp/mount.sh",
    ]
  }
}

