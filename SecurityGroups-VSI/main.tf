provider "ibm" {
  bluemix_api_key    = "${var.bxapikey}"
  softlayer_username = "${var.slusername}"
  softlayer_api_key  = "${var.slapikey}"
}

data "ibm_compute_ssh_key" "terra" {
    label = "terra"
}

resource "ibm_security_group" "sgterraform" {
    name = "sgterraform"
    description = "allow my server traffic"
}

resource "ibm_security_group_rule" "allow_ssh_home" {
    direction = "ingress"
    ether_type = "IPv4"
    port_range_min = 22
    port_range_max = 22
    protocol = "tcp"
    remote_ip = "192.168.0.100"
    security_group_id = "${ibm_security_group.sgterraform.id}"
}

resource "ibm_security_group_rule" "allow_ssh_work" {
    direction = "ingress"
    ether_type = "IPv4"
    port_range_min = 22
    port_range_max = 22
    protocol = "tcp"
    remote_ip = "192.168.0.200"
    security_group_id = "${ibm_security_group.sgterraform.id}"
}

resource "ibm_security_group_rule" "allow_ssh_jumpbox" {
    direction = "ingress"
    ether_type = "IPv4"
    port_range_min = 22
    port_range_max = 22
    protocol = "tcp"
    remote_ip = "192.168.0.300"
    security_group_id = "${ibm_security_group.sgterraform.id}"
}

resource "ibm_compute_vm_instance" "node" {
    hostname = "sgtest"
    domain = "${var.domainname}"
    os_reference_code = "${var.os}"
    datacenter = "${var.datacenter}"
    network_speed = 1000
    hourly_billing = true
    private_network_only = false 
    cores = "${var.vm_cores}"
    memory = "${var.vm_memory}"
    disks = [100]
    local_disk = false
    private_vlan_id = "${var.priv_vlan}"
    public_vlan_id = "${var.pub_vlan}"
    ssh_key_ids = ["${data.ibm_compute_ssh_key.sshkey.id}"]
    public_security_group_ids = ["${ibm_security_group.sgterraform.id}"]
}