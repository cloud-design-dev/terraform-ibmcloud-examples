# Configure the IBM Cloud Provider
provider "ibm" {
  bluemix_api_key    = "${var.ibm_bx_api_key}"
  softlayer_username = "${var.ibm_sl_username}"
  softlayer_api_key  = "${var.ibm_sl_api_key}"
}

data "ibm_compute_ssh_key" "sshkey" {
  label = "ryan_terra"
}

data "ibm_org" "orgData" {
  org = "${var.ibm_bmx_org}"
}

data "ibm_account" "accountData" {
  org_guid = "${data.ibm_org.orgData.id}"
}

data "ibm_space" "spaceData" {
  space = "${var.ibm_bmx_space}"
  org   = "${var.ibm_bmx_org}"
}

resource "ibm_service_instance" "tflogging" {
  name       = "tflogging"
  space_guid = "${data.ibm_space.spaceData.id}"
  service    = "ibmloganalysis"
  plan       = "standard"

  provisioner "local-exec" {
    command = "bx logging token-get >> logtoken"
  }
}

resource "ibm_compute_vm_instance" "node" {
  depends_on           = ["ibm_service_instance.tflogging"]
  hostname             = "tflogtests"
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
    source      = "logtoken"
    destination = "/tmp/logtoken"
  }
  provisioner "file" {
    source = "mt-lsf-config.sh"
    destination = "/tmp/mt-lsf-config.sh"
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
    command = "rm -f logtoken"
  }
}
