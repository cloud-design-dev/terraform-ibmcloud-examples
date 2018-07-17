# Configure the IBM Cloud Provider
provider "ibm" {
 softlayer_username = "${var.slusername}"
 softlayer_api_key  = "${var.slapikey}"
}

# This should be the SSH key of the server or system you are running the terraform binary on. 
# Terraform will use this key for communication with the VRA 

data "ibm_compute_ssh_key" "sshkey" {
 label = "NAME_OF_SSH_KEY"
}

resource "ibm_network_gateway" "gateway" {
 name        = "mytfgateway"
 ssh_key_ids = ["${data.ibm_compute_ssh_key.sshkey.id}"]

 members {
   hostname         = "mytfgateway"
   domain           = "${var.domainname}"
   datacenter       = "${var.datacenter}"
   network_speed    = 1000
   tcp_monitoring   = true
   tags             = ["your tags"]
   # public_vlan_id   = "${var.pub_vlan}"
   # private_vlan_id  = "${var.priv_vlan}"
   ssh_key_ids      = ["${data.ibm_compute_ssh_key.sshkey.id}"]
   notes            = "Testing VRA and Terraform"
   process_key_name = "INTEL_SINGLE_XEON_1270_3_50"
   os_key_name      = "OS_VYATTA_5600_5_X_UP_TO_1GBPS_SUBSCRIPTION_EDITION_64_BIT"
   disk_key_names   = ["HARD_DRIVE_2_00TB_SATA_II"]
   public_bandwidth = 20000
   memory           = "${var.vra_memory}"
   ipv6_enabled     = true
 }

 connection {
   type        = "ssh"
   user        = "vyatta"
   host        = "${self.public_ipv4_address}"
   private_key = "${file("~/.ssh/id_rsa")}"
 }

 provisioner "file" {
   source      = "create-vifs.vcli"
   destination = "/tmp/create-vifs.vcli"
 }

 provisioner "remote-exec" {
   inline = [
     "chmod +x /tmp/create-vifs.vcli",
     "/tmp/create-vifs.vcli",
   ]
 }