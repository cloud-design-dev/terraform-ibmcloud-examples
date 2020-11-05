data "ibm_compute_ssh_key" "sshkey" {
  label = var.ssh_key
}

resource "ibm_compute_vm_instance" "minio_node" {
  count                = var.count
  hostname             = "node${count.index + 1}"
  domain               = var.domainname
  os_reference_code    = var.os
  datacenter           = var.datacenter
  network_speed        = 1000
  user_metadata        = file("minio_installer.sh")
  hourly_billing       = true
  private_network_only = false
  disks                = [100, 2000, 2000, 2000, 2000]
  local_disk           = false
  ssh_key_ids          = [data.ibm_compute_ssh_key.sshkey.id]

  tags = [
    var.datacenter,
    "minio",
  ]
}

resource "ibm_lbaas" "lbaas" {
  depends_on  = [ibm_compute_vm_instance.minio_node]
  name        = "minio"
  description = "LBaaS spun up using terraform"
  subnets     = [1470945]

  protocols {
    frontend_protocol     = "TCP"
    frontend_port         = 80
    backend_protocol      = "TCP"
    backend_port          = 9000
    load_balancing_method = "round_robin"
  }

  server_instances {
    private_ip_address = element(ibm_compute_vm_instance.minio_node.*.ipv4_address_private, count.index)
  }
}

resource "ibm_dns_record" "minio" {
  data      = element(ibm_compute_vm_instance.minio_node.*.ipv4_address_private, count.index)
  domain_id = data.ibm_dns_domain.main.id
  host      = "node${count.index + 1}"
  ttl       = 900
  type      = "a"
}

