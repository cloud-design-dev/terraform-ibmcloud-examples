resource "ibm_is_public_gateway" "z1_iks_gateway" {
  name           = "z1-iks-gw"
  vpc            = var.vpc_id
  zone           = var.zones[0]
  resource_group = var.resource_group
}

resource "ibm_is_public_gateway" "z2_iks_gateway" {
  name           = "z2-iks-gw"
  vpc            = var.vpc_id
  zone           = var.zones[1]
  resource_group = var.resource_group
}

resource "ibm_is_public_gateway" "z3_iks_gateway" {
  name           = "z3-iks-gw"
  vpc            = var.vpc_id
  zone           = var.zones[2]
  resource_group = var.resource_group
}

resource "ibm_is_subnet" "z1_iks_subnet" {
  depends_on      = [ibm_is_public_gateway.z1_iks_gateway]
  name            = "z1-iks-subnet"
  ipv4_cidr_block = "10.240.0.0/24"
  vpc             = var.vpc_id
  zone            = var.zones[0]
  resource_group  = var.resource_group
  public_gateway  = ibm_is_public_gateway.z1_iks_gateway.id
}

resource "ibm_is_subnet" "z2_iks_subnet" {
  depends_on      = [ibm_is_public_gateway.z2_iks_gateway]
  name            = "z2-iks-subnet"
  ipv4_cidr_block = "10.240.64.0/24"
  vpc             = var.vpc_id
  zone            = var.zones[1]
  resource_group  = var.resource_group
  public_gateway  = ibm_is_public_gateway.z2_iks_gateway.id
}

resource "ibm_is_subnet" "z3_iks_subnet" {
  depends_on      = [ibm_is_public_gateway.z3_iks_gateway]
  name            = "z3-iks-subnet"
  ipv4_cidr_block = "10.240.128.0/24"
  vpc             = var.vpc_id
  zone            = var.zones[2]
  resource_group  = var.resource_group
  public_gateway  = ibm_is_public_gateway.z3_iks_gateway.id
}

resource "ibm_is_security_group_rule" "vpc_loadbal_sg_rule" {
  group     = data.ibm_is_vpc.default.default_security_group
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = "30000"
    port_max = "32767"
  }
}

resource "ibm_is_security_group_rule" "vpc_loadbal_sg_rule_udp" {
  group     = data.ibm_is_vpc.default.default_security_group
  direction = "inbound"
  remote    = "0.0.0.0/0"
  udp {
    port_min = "30000"
    port_max = "32767"
  }
}