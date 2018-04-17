data "ibm_compute_ssh_key" "sshkey" {
  label = "ryan_ganymede"
}

resource "ibm_compute_vm_instance" "node" {
  count                      = "${var.node_count}"
  hostname                   = "node${count.index+1}"
  domain                     = "${var.domainname}"
  os_reference_code          = "${var.os}"
  datacenter                 = "${var.datacenter}"
  network_speed              = 1000
  hourly_billing             = true
  private_network_only       = false
  cores                      = "${var.vm_cores}"
  memory                     = "${var.vm_memory}"
  disks                      = [100]
  local_disk                 = false
  public_vlan_id             = "${var.pub_vlan}"
  private_vlan_id            = "${var.priv_vlan}"
  ssh_key_ids                = ["${data.ibm_compute_ssh_key.sshkey.id}"]
  public_security_group_ids  = [369163]
  private_security_group_ids = [369163]

  tags = [
    "ryantiffany",
    "createdwithtf",
  ]

  provisioner "file" {
    source      = "${path.module}/scripts/index.html"
    destination = "/tmp/index.html"
  }

  provisioner "file" {
    source      = "${path.module}/scripts/postinstall.sh"
    destination = "/tmp/postinstall.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/postinstall.sh",
      "/tmp/postinstall.sh",
    ]
  }
}

resource "ibm_lbaas" "lbaas" {
  depends_on  = ["ibm_compute_vm_instance.node"]
  name        = "tflbaas"
  description = "LBaaS spun up using terraform"
  subnets     = [1470945]

  protocols = [{
    "frontend_protocol"     = "HTTP"
    "frontend_port"         = 80
    "backend_protocol"      = "HTTP"
    "backend_port"          = 80
    "load_balancing_method" = "round_robin"
  }]

  server_instances = [
    {
      "private_ip_address" = "${ibm_compute_vm_instance.node.0.ipv4_address_private}"
    },
    {
      "private_ip_address" = "${ibm_compute_vm_instance.node.1.ipv4_address_private}"
    },
    {
      "private_ip_address" = "${ibm_compute_vm_instance.node.2.ipv4_address_private}"
    },
  ]
}
