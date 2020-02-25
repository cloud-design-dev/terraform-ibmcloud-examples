data "ibm_compute_ssh_key" "public_key" {
    label = "Terraform Public Key"
}

resource "ibm_storage_file" "fs_performance" {
        type = "Performance"
        datacenter = "${var.datacenter}"
        capacity = 20
        iops = 100
        hourly_billing = true

    provisioner "local-exec" {
        command = "echo ${ibm_storage_file.fs_performance.mountpoint} >> ${ibm_storage_file.fs_performance.id}_mountpath.txt"
    }    
}

resource "ibm_compute_vm_instance" "fsvsitest" {
   depends_on = ["ibm_storage_file.fs_performance"]
   hostname = "fsvsitest"
   os_reference_code = "${var.os}"
   domain = "${var.domain}"
   datacenter = "${var.datacenter}"
   network_speed  = 1000
   hourly_billing = true
   flavor_key_name = "${var.vm_flavor}"
   public_vlan_id = "${var.public_vlan}"
   private_vlan_id = "${var.private_vlan}"
   local_disk = false
   tags = [
     "filestorage",
     "terraform"
   ]
   ssh_key_ids = ["${data.ibm_compute_ssh_key.public_key.id}"]
   file_storage_ids = ["${ibm_storage_file.fs_performance.id}"]

  provisioner "file" {
    source      = "mountstorage.sh"
    destination = "/tmp/mountstorage.sh"
}

  provisioner "file" {
    source      = "${ibm_storage_file.fs_performance.id}_mountpath.txt"
    destination = "/tmp/mountpath.txt"

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/mountstorage.sh",
      "/tmp/mountstorage.sh",
    ]
  }
}
}