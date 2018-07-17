# Softlayer username
variable slusername {}

# SoftLayer API key
variable slapikey {}

# The target operating system for the web nodes
variable os {
  default = "CENTOS_6_64"
}

# The number of cores each web virtual guest will recieve
variable vm_cores {
  default = 2
}
# The amount of memory each web virtual guest will recieve
variable vm_memory {
  default = 4096
}

# The datacenter to deploy to
variable datacenter1 {
 default = "dal05"
}

# vlan 1326
# The private vlan to deploy the virtual guests on to
variable vra1priv_vlan {
 default = 195507
}

# vlan 1327
variable vra1pub_vlan {
 default = 195506
}

# The second datacenter to deploy to
variable datacenter2 {
 default = "dal05"
}

# vlan 1160
# The private vlan to deploy the virtual guests on to
variable vra2priv_vlan {
 default = 206503
}

# vlan 1317
variable vra2pub_vlan {
 default = 125825
}

# The domain name for the virtual guests
variable domainname {
 default = "cde.services"
}

##############################################################################
# Configures the IBM Cloud provider
# https://ibm-bluemix.github.io/tf-ibm-docs/
##############################################################################
# Configure the IBM Cloud Provider
provider "ibm" {
 softlayer_username = "${var.slusername}"
 softlayer_api_key  = "${var.slapikey}"
}

data "ibm_compute_ssh_key" "sshkey" {
 label = "tfdev"
}

resource "ibm_network_gateway" "vra1" {
 name        = "vra1"
 ssh_key_ids = ["${data.ibm_compute_ssh_key.sshkey.id}"]

 members {
   hostname         = "vra1"
   domain           = "${var.domainname}"
   datacenter       = "${var.datacenter1}"
   network_speed    = 1000
   tcp_monitoring   = true
   tags             = ["ryant"]
   public_vlan_id   = "${var.vra1pub_vlan}"
   private_vlan_id  = "${var.vra1priv_vlan}"
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
   source      = "vra1create-vifs.vcli"
   destination = "/tmp/vra1create-vifs.vcli"
 }

 provisioner "remote-exec" {
   inline = [
     "chmod +x /tmp/vra1create-vifs.vcli",
     "/tmp/vra1create-vifs.vcli",
   ]
 }
}


resource "ibm_network_gateway" "vra2" {
 name        = "vra2"
 ssh_key_ids = ["${data.ibm_compute_ssh_key.sshkey.id}"]

 members {
   hostname         = "vra2"
   domain           = "${var.domainname}"
   datacenter       = "${var.datacenter2}"
   network_speed    = 1000
   tcp_monitoring   = true
   tags             = ["ryant"]
   public_vlan_id   = "${var.vra2pub_vlan}"
   private_vlan_id  = "${var.vra2priv_vlan}"
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
   source      = "vra2create-vifs.vcli"
   destination = "/tmp/vra2create-vifs.vcli"
 }

 provisioner "remote-exec" {
   inline = [
     "chmod +x /tmp/vra2create-vifs.vcli",
     "/tmp/vra2create-vifs.vcli",
   ]
 }
}

resource "ibm_compute_vm_instance" "vratestnode1" {
    hostname = "vratestnode1"
    domain = "${var.domainname}"
    os_reference_code = "${var.os}"
    datacenter = "${var.datacenter1}"
    network_speed = 1000
    hourly_billing = true
    private_network_only = false
    cores = "${var.vm_cores}"
    memory = "${var.vm_memory}"
    disks = [100]
    local_disk = false
    public_vlan_id = "${var.vra1pub_vlan}"
    private_vlan_id = "${var.vra1priv_vlan}"
    ssh_key_ids = ["${data.ibm_compute_ssh_key.sshkey.id}"]
    provisioner "file" {
    source      = "vratestnode1_server_postinstall.sh"
    destination = "/tmp/vratestnode1_server_postinstall.sh"
    }
    provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/vratestnode1_server_postinstall.sh",
      "/tmp/vratestnode1_server_postinstall.sh",
    ]
    }
    provisioner "remote-exec" {
    inline = [
      "shutdown -r now",
    ]
  }
}

resource "ibm_compute_vm_instance" "vratestnode2" {
    hostname = "vratestnode2"
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
    public_vlan_id = "${var.vra2pub_vlan}"
    private_vlan_id = "${var.vra2priv_vlan}"
    ssh_key_ids = ["${data.ibm_compute_ssh_key.sshkey.id}"]
    provisioner "file" {
    source      = "vratestnode2_server_postinstall.sh"
    destination = "/tmp/vratestnode2_server_postinstall.sh"
    }
    provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/vratestnode2_server_postinstall.sh",
      "/tmp/vratestnode2_server_postinstall.sh",
    ]
    }
    provisioner "remote-exec" {
    inline = [
      "shutdown -r now",
    ]
  }
}

resource "ibm_network_gateway_vlan_association" "vra1_public_vlan_association" {
  gateway_id      = "${ibm_network_gateway.vra1.id}"
  network_vlan_id = 125825
}

resource "ibm_network_gateway_vlan_association" "vra1_private_vlan_association" {
  gateway_id      = "${ibm_network_gateway.vra1.id}"
  network_vlan_id = 195507
}

resource "ibm_network_gateway_vlan_association" "vra2_private_vlan_association" {
  gateway_id      = "${ibm_network_gateway.vra2.id}"
  network_vlan_id = 206503
}

resource "ibm_network_gateway_vlan_association" "vra2_public_vlan_association" {
  gateway_id      = "${ibm_network_gateway.vra2.id}"
  network_vlan_id = 236968
}
