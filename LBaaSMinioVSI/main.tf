data "ibm_compute_ssh_key" "sshkey" {
  label = "ryan_terra"
}

# data "ibm_dns_domain" "domain_id" {
#   name = "greyhoundforty.codes"
# }

resource "ibm_compute_vm_instance" "node0" {
  # count                = "${var.count}"
  hostname             = "node0"
  domain               = "${var.domainname}"
  os_reference_code    = "${var.os}"
  datacenter           = "${var.datacenter}"
  network_speed        = 1000
  user_metadata        = "{\"MINIO_ACCESS_KEY=${var.maccess}\" : \"MINIO_SECRET_KEY=${var.msecret}\"}"
  hourly_billing       = true
  private_network_only = false
  cores                = "${var.vm_cores}"
  memory               = "${var.vm_memory}"
  disks                = [100, 2000, 2000, 2000, 2000]
  local_disk           = false
  public_vlan_id       = "${var.pub_vlan}"
  private_vlan_id      = "${var.priv_vlan}"
  ssh_key_ids          = ["${data.ibm_compute_ssh_key.sshkey.id}"]

  tags = [
    "ryantiffany",
    "createdwithtf",
  ]

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
}

resource "ibm_compute_vm_instance" "node1" {
  # count                = "${var.count}"
  hostname             = "node1"
  domain               = "${var.domainname}"
  os_reference_code    = "${var.os}"
  datacenter           = "${var.datacenter}"
  network_speed        = 1000
  hourly_billing       = true
  user_metadata        = "{\"MINIO_ACCESS_KEY=${var.maccess}\" : \"MINIO_SECRET_KEY=${var.msecret}\"}"
  private_network_only = false
  cores                = "${var.vm_cores}"
  memory               = "${var.vm_memory}"
  disks                = [100, 2000, 2000, 2000, 2000]
  local_disk           = false
  public_vlan_id       = "${var.pub_vlan}"
  private_vlan_id      = "${var.priv_vlan}"
  ssh_key_ids          = ["${data.ibm_compute_ssh_key.sshkey.id}"]

  tags = [
    "ryantiffany",
    "createdwithtf",
  ]

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
}

resource "ibm_compute_vm_instance" "node2" {
  # count                = "${var.count}"
  hostname             = "node2"
  domain               = "${var.domainname}"
  os_reference_code    = "${var.os}"
  datacenter           = "${var.datacenter}"
  network_speed        = 1000
  user_metadata        = "{\"MINIO_ACCESS_KEY=${var.maccess}\" : \"MINIO_SECRET_KEY=${var.msecret}\"}"
  hourly_billing       = true
  private_network_only = false
  cores                = "${var.vm_cores}"
  memory               = "${var.vm_memory}"
  disks                = [100, 2000, 2000, 2000, 2000]
  local_disk           = false
  public_vlan_id       = "${var.pub_vlan}"
  private_vlan_id      = "${var.priv_vlan}"
  ssh_key_ids          = ["${data.ibm_compute_ssh_key.sshkey.id}"]

  tags = [
    "ryantiffany",
    "createdwithtf",
  ]

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
}

resource "ibm_compute_vm_instance" "node3" {
  # count                = "${var.count}"
  hostname             = "node3"
  domain               = "${var.domainname}"
  os_reference_code    = "${var.os}"
  datacenter           = "${var.datacenter}"
  network_speed        = 1000
  user_metadata        = "{\"MINIO_ACCESS_KEY=${var.maccess}\" : \"MINIO_SECRET_KEY=${var.msecret}\"}"
  hourly_billing       = true
  private_network_only = false
  cores                = "${var.vm_cores}"
  memory               = "${var.vm_memory}"
  disks                = [100, 2000, 2000, 2000, 2000]
  local_disk           = false
  public_vlan_id       = "${var.pub_vlan}"
  private_vlan_id      = "${var.priv_vlan}"
  ssh_key_ids          = ["${data.ibm_compute_ssh_key.sshkey.id}"]

  tags = [
    "ryantiffany",
    "createdwithtf",
  ]

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
}

resource "ibm_lbaas" "lbaas" {
  name        = "minio"
  description = "LBaaS spun up using terraform"
  subnets     = [1470945]

  protocols = [{
    "frontend_protocol"     = "TCP"
    "frontend_port"         = 80
    "backend_protocol"      = "TCP"
    "backend_port"          = 9000
    "load_balancing_method" = "round_robin"
  }]

  server_instances = [
    {
      "private_ip_address" = "${ibm_compute_vm_instance.node0.ipv4_address_private}"
    },
    {
      "private_ip_address" = "${ibm_compute_vm_instance.node1.ipv4_address_private}"
    },
    {
      "private_ip_address" = "${ibm_compute_vm_instance.node2.ipv4_address_private}"
    },
    {
      "private_ip_address" = "${ibm_compute_vm_instance.node3.ipv4_address_private}"
    },
  ]
}

# Add a record to a sub-domain
resource "dnsimple_record" "node0" {
  depends_on = ["ibm_compute_vm_instance.node0"]
  domain     = "${var.dnsimple_domain}"
  name       = "node0"
  value      = "${ibm_compute_vm_instance.node0.ipv4_address_private}"
  type       = "A"
  ttl        = 3600
}

resource "dnsimple_record" "node1" {
  depends_on = ["ibm_compute_vm_instance.node1"]
  domain     = "${var.dnsimple_domain}"
  name       = "node1"
  value      = "${ibm_compute_vm_instance.node1.ipv4_address_private}"
  type       = "A"
  ttl        = 3600
}

resource "dnsimple_record" "node2" {
  depends_on = ["ibm_compute_vm_instance.node2"]
  domain     = "${var.dnsimple_domain}"
  name       = "node2"
  value      = "${ibm_compute_vm_instance.node2.ipv4_address_private}"
  type       = "A"
  ttl        = 3600
}

resource "dnsimple_record" "node3" {
  depends_on = ["ibm_compute_vm_instance.node3"]
  domain     = "${var.dnsimple_domain}"
  name       = "node3"
  value      = "${ibm_compute_vm_instance.node3.ipv4_address_private}"
  type       = "A"
  ttl        = 3600
}

resource "dnsimple_record" "lb" {
  depends_on = ["ibm_lbaas.lbaas"]
  domain     = "${var.dnsimple_domain}"
  name       = "minio"
  value      = "${ibm_lbaas.lbaas.vip}"
  type       = "A"
  ttl        = 900
}
