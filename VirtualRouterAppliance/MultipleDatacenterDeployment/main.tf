
# Configure the IBM Cloud Provider
provider "ibm" {
 softlayer_username = "${var.slusername}"
 softlayer_api_key  = "${var.slapikey}"
}

data "ibm_compute_ssh_key" "sshkey" {
 label = "tfdev"
}

resource "ibm_network_gateway" "dal13tfgateway" {
 name        = "dal13tfgateway"
 ssh_key_ids = ["${data.ibm_compute_ssh_key.sshkey.id}"]

 members {
   hostname         = "dal13tfgateway"
   domain           = "${var.domainname}"
   datacenter       = "${var.datacenter1}"
   network_speed    = 1000
   tcp_monitoring   = true
   tags             = ["ryant"]
   public_vlan_id   = "${var.dal13pub_vlan}"
   private_vlan_id  = "${var.dal13priv_vlan}"
   ssh_key_ids      = ["${data.ibm_compute_ssh_key.sshkey.id}"]
   notes            = "Testing VRA and Terraform"
   process_key_name = "INTEL_SINGLE_XEON_1270_3_50"
   os_key_name      = "OS_VYATTA_5600_5_X_UP_TO_1GBPS_SUBSCRIPTION_EDITION_64_BIT"
   disk_key_names   = ["HARD_DRIVE_2_00TB_SATA_II"]
   public_bandwidth = 20000
   memory           = 16
   ipv6_enabled     = true
 }

 connection {
   type        = "ssh"
   user        = "vyatta"
   host        = "${self.public_ipv4_address}"
   private_key = "${file("~/.ssh/id_rsa")}"
 }

 provisioner "file" {
   source      = "dal13create-vifs.vcli"
   destination = "/tmp/dal13create-vifs.vcli"
 }

 provisioner "remote-exec" {
   inline = [
     "chmod +x /tmp/dal13create-vifs.vcli",
     "/tmp/dal13create-vifs.vcli",
   ]
 }

  provisioner "file" {
   source      = "dal13create-tunnels.vcli"
   destination = "/tmp/dal13create-tunnels.vcli"
 }
 
 provisioner "remote-exec" {
   inline = [
     "chmod +x /tmp/dal13create-tunnels.vcli",
   ]
 }

 provisioner "file" {
   source      = "dal13tunnelprompt.sh"
   destination = "/tmp/dal13tunnelprompt.sh"
 }

 provisioner "remote-exec" {
   inline = [
     "chmod +x /tmp/dal13tunnelprompt.sh",
   ]
 } 
  
 provisioner "local-exec" {
  command = "echo ${ibm_network_gateway.dal13tfgateway.public_ipv4_address} >> $HOME/dal13tfgateway_public_ip.txt"
 } 
}



resource "ibm_network_gateway" "wdc07tfgateway" {
 name        = "wdc07tfgateway"
 ssh_key_ids = ["${data.ibm_compute_ssh_key.sshkey.id}"]

 members {
   hostname         = "wdc07tfgateway"
   domain           = "${var.domainname}"
   datacenter       = "${var.datacenter2}"
   network_speed    = 1000
   tcp_monitoring   = true
   tags             = ["ryant"]
   public_vlan_id   = "${var.wdc07pub_vlan}"
   private_vlan_id  = "${var.wdc07priv_vlan}"
   ssh_key_ids      = ["${data.ibm_compute_ssh_key.sshkey.id}"]
   notes            = "Testing VRA and Terraform"
   process_key_name = "INTEL_SINGLE_XEON_1270_3_40_2"
   os_key_name      = "OS_VYATTA_5600_5_X_UP_TO_1GBPS_SUBSCRIPTION_EDITION_64_BIT"
   disk_key_names   = ["HARD_DRIVE_2_00TB_SATA_II"]
   public_bandwidth = 20000
   memory           = 16
   ipv6_enabled     = true
 }

 connection {
   type        = "ssh"
   user        = "vyatta"
   host        = "${self.public_ipv4_address}"
   private_key = "${file("~/.ssh/id_rsa")}"
 }

 provisioner "file" {
   source      = "wdc07create-vifs.vcli"
   destination = "/tmp/wdc07create-vifs.vcli"
 }

 provisioner "remote-exec" {
   inline = [
     "chmod +x /tmp/wdc07create-vifs.vcli",
     "/tmp/wdc07create-vifs.vcli",
   ]
 }

 provisioner "file" {
   source      = "wdc07create-tunnels.vcli"
   destination = "/tmp/wdc07create-tunnels.vcli"
 }
 
 provisioner "remote-exec" {
   inline = [
     "chmod +x /tmp/wdc07create-tunnels.vcli",
   ]
 }

 provisioner "file" {
   source      = "wdc07tunnelprompt.sh"
   destination = "/tmp/wdc07tunnelprompt.sh"
 }

 provisioner "remote-exec" {
   inline = [
     "chmod +x /tmp/wdc07tunnelprompt.sh",
   ]
 }

 provisioner "local-exec" {
  command = "echo ${ibm_network_gateway.wdc07tfgateway.public_ipv4_address} >> $HOME/wdc07tfgateway_public_ip.txt"
 } 
}

resource "ibm_compute_vm_instance" "dal13node" {
    hostname = "dal13node"
    domain = "${var.domainname}"
    os_reference_code = "${var.os}"
    datacenter = "${var.datacenter1}"
    network_speed = 1000
    hourly_billing = true
    private_network_only = false
    user_metadata    = "{\"SOFTLAYER_USERNAME=${var.slusername}\" : \"SOFTLAYER_API_KEY=${var.slapikey}\"}"
    cores = "${var.vm_cores}"
    memory = "${var.vm_memory}"
    disks = [100]
    local_disk = false
    public_vlan_id   = "${var.dal13pub_vlan}"
    private_vlan_id  = "${var.dal13priv_vlan}"
    ssh_key_ids = ["${data.ibm_compute_ssh_key.sshkey.id}"]
    depends_on = ["ibm_network_gateway.dal13tfgateway"]
    
    provisioner "file" {
    source      = "dal13server_postinstall.sh"
    destination = "/tmp/dal13server_postinstall.sh"
    }
    provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/dal13server_postinstall.sh",
      "/tmp/dal13server_postinstall.sh",
    ]
    }
}

resource "ibm_compute_vm_instance" "wdc07node" {
    hostname = "wdc07node"
    domain = "${var.domainname}"
    os_reference_code = "${var.os}"
    datacenter = "${var.datacenter2}"
    network_speed = 1000
    hourly_billing = true
    private_network_only = false
    cores = "${var.vm_cores}"
    memory = "${var.vm_memory}"
    disks = [100]
    local_disk = false
    public_vlan_id   = "${var.wdc07pub_vlan}"
    private_vlan_id  = "${var.wdc07priv_vlan}"
    ssh_key_ids = ["${data.ibm_compute_ssh_key.sshkey.id}"]
    provisioner "file" {
    source      = "wdc07server_postinstall.sh"
    destination = "/tmp/wdc07server_postinstall.sh"
    }
    provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/wdc07server_postinstall.sh",
      "/tmp/wdc07server_postinstall.sh",
    ]
    }
}

output "dal13vravlans" {
  value = "${ibm_network_gateway.dal13tfgateway.associated_vlans}"
}

output "wdc07vravlans" {
  value = "${ibm_network_gateway.wdc07tfgateway.associated_vlans}"
}