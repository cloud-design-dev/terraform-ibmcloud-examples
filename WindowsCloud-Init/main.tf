resource "ibm_compute_vm_instance" "wincloudtest" {
   hostname = "wincloudtest"
   domain = "${var.domainname}"
   datacenter = "${var.datacenter}"
   user_metadata = "${file("cloud-config.yml")}"
   hourly_billing = false
   flavor_key_name = "${var.vm_flavor}"
   public_vlan_id = "${var.public_vlan}"
   private_vlan_id = "${var.private_vlan}"
   local_disk = false
   os_reference_code = "WIN_2016-STD_64"
   tags = [
     "ryantiffany"
   ]
}
