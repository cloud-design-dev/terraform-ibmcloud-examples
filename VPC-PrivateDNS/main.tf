resource tls_private_key ssh {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource ibm_is_ssh_key generated_key {
  name           = "${var.project_name}-${var.region}-sshkey"
  public_key     = tls_private_key.ssh.public_key_openssh
  resource_group = data.ibm_resource_group.project_group.id
  tags           = concat(var.tags, ["region:${var.region}", "project:${var.project_name}", "terraform:workspace:${terraform.workspace}"])
}

resource "ibm_is_vpc" "vpc" {
  name           = "${var.project_name}-vpc"
  resource_group = data.ibm_resource_group.project_group.id
  tags           = concat(var.tags, ["vpc"])
}

resource ibm_is_public_gateway gateway {
  name           = "${var.project_name}-gateway"
  vpc            = ibm_is_vpc.vpc.id
  zone           = data.ibm_is_zones.mzr.zones[0]
  resource_group = data.ibm_resource_group.project_group.id
}

resource ibm_is_subnet subnet {
  name                     = "${var.project_name}-subnet"
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = data.ibm_is_zones.mzr.zones[0]
  total_ipv4_address_count = var.address_count
  network_acl              = ibm_is_vpc.vpc.default_network_acl
  public_gateway           = ibm_is_public_gateway.gateway.id
  resource_group           = data.ibm_resource_group.project_group.id
}

resource ibm_is_security_group_rule ssh_in {
  group     = ibm_is_vpc.vpc.default_security_group
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource ibm_is_security_group_rule http_in {
  group     = ibm_is_vpc.vpc.default_security_group
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 80
    port_max = 80
  }
}


resource ibm_is_security_group_rule all_out {
  group     = ibm_is_vpc.vpc.default_security_group
  direction = "outbound"
  remote    = "0.0.0.0/0"
}

resource "ibm_is_instance" "instance" {
  count          = var.instance_count
  name           = "${var.project_name}-instance-${count.index + 1}"
  vpc            = ibm_is_vpc.vpc.id
  zone           = data.ibm_is_zones.mzr.zones[0]
  profile        = var.profile
  image          = data.ibm_is_image.image.id
  keys           = [ibm_is_ssh_key.generated_key.id]
  resource_group = data.ibm_resource_group.project_group.id

  # inject dns config
  user_data = file("${path.module}/install.yml")

  primary_network_interface {
    subnet          = ibm_is_subnet.subnet.id
    security_groups = [ibm_is_vpc.vpc.default_security_group]
  }

  boot_volume {
    name = "${var.project_name}-instance-${count.index + 1}-boot"
  }

  tags = concat(var.tags, ["instance"])
}


resource "ibm_is_floating_ip" "ip" {
  name           = "${var.project_name}-bastion-fip"
  target         = ibm_is_instance.instance[0].primary_network_interface[0].id
  resource_group = data.ibm_resource_group.project_group.id
}

resource "ibm_resource_instance" "project_instance" {
  name              = "${var.project_name}-dns-instance"
  resource_group_id = data.ibm_resource_group.project_group.id
  location          = "global"
  service           = "dns-svcs"
  plan              = "standard-dns"
}

resource "ibm_dns_zone" "zone" {
  name        = var.domain
  instance_id = ibm_resource_instance.project_instance.guid
  description = "Private DNS Zone for VPC DNS communication."
  label       = "testlabel"
}

resource "ibm_dns_permitted_network" "permitted_network" {
  instance_id = ibm_resource_instance.project_instance.guid
  zone_id     = ibm_dns_zone.zone.zone_id
  vpc_crn     = ibm_is_vpc.vpc.crn
  type        = "vpc"
}

resource "ibm_dns_resource_record" "a_records" {
  count       = var.instance_count
  instance_id = ibm_resource_instance.project_instance.guid
  zone_id     = ibm_dns_zone.zone.zone_id
  type        = "A"
  name        = "${var.project_name}-instance-${count.index + 1}"
  rdata       = element(ibm_is_instance.instance[*].primary_network_interface[0].primary_ipv4_address, count.index)
  ttl         = 3600
}

resource "local_file" "ssh-key" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "${path.module}/generated_key_rsa"
  file_permission = "0600"
}