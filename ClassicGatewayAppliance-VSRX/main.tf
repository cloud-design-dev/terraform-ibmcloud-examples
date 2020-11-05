resource "ibm_network_vlan" "ha_srx_public_vlan" {
  name            = "srx-public-rt"
  datacenter      = var.datacenter
  type            = "PUBLIC"
  router_hostname = "fcr01a.${var.datacenter}"
  tags            = [var.datacenter]
}

resource "ibm_network_vlan" "ha_srx_private_vlan" {
  name            = "srx-private-rt"
  datacenter      = var.datacenter
  type            = "PRIVATE"
  router_hostname = "bcr01a.${var.datacenter}"
  tags            = [var.datacenter]
}

resource "ibm_network_gateway" "ha_vsrx" {
  name = "ha-srx"

  members {
    hostname             = "ha1-srx-${var.datacenter}"
    domain               = var.domainname
    datacenter           = var.datacenter
    network_speed        = 10000
    private_network_only = false
    tcp_monitoring       = true
    package_key_name     = "VIRTUAL_ROUTER_APPLIANCE_10_GPBS"
    process_key_name     = "INTEL_INTEL_XEON_5120_2_20"
    os_key_name          = "OS_JUNIPER_VSRX_15_X_UP_TO_10GBPS_STANDARD_SRIOV"
    redundant_network    = true
    disk_key_names       = ["HARD_DRIVE_2_00_TB_SATA_2"]
    public_bandwidth     = 20000
    memory               = 64
    public_vlan_id       = ibm_network_vlan.ha_srx_public_vlan.id
    private_vlan_id      = ibm_network_vlan.ha_srx_private_vlan.id
    tags                 = ["vsrx-ha-node1"]
    notes                = "testing the deployment of an srx via terraform"
    ipv6_enabled         = true
    ssh_key_ids          = [data.ibm_compute_ssh_key.ssh.id]
  }
  members {
    hostname             = "ha2-srx-${var.datacenter}"
    domain               = var.domainname
    datacenter           = var.datacenter
    network_speed        = 10000
    private_network_only = false
    tcp_monitoring       = true
    package_key_name     = "VIRTUAL_ROUTER_APPLIANCE_10_GPBS"
    process_key_name     = "INTEL_INTEL_XEON_5120_2_20"
    os_key_name          = "OS_JUNIPER_VSRX_15_X_UP_TO_10GBPS_STANDARD_SRIOV"
    redundant_network    = true
    disk_key_names       = ["HARD_DRIVE_2_00_TB_SATA_2"]
    public_bandwidth     = 20000
    memory               = 64
    public_vlan_id       = ibm_network_vlan.ha_srx_public_vlan.id
    private_vlan_id      = ibm_network_vlan.ha_srx_private_vlan.id
    tags                 = ["vsrx-ha-node2"]
    notes                = "testing the deployment of an srx via terraform"
    ipv6_enabled         = true
    ssh_key_ids          = [data.ibm_compute_ssh_key.ssh.id]
  }
}

resource "ibm_network_gateway_vlan_association" "public_association" {
  depends_on      = [ibm_network_gateway.ha_vsrx]
  gateway_id      = ibm_network_gateway.ha_vsrx.id
  network_vlan_id = ibm_network_vlan.ha_srx_public_vlan.id
  bypass          = false
}

resource "ibm_network_gateway_vlan_association" "private_association" {
  depends_on      = [ibm_network_gateway.ha_vsrx]
  gateway_id      = ibm_network_gateway.ha_vsrx.id
  network_vlan_id = ibm_network_vlan.ha_srx_private_vlan.id
  bypass          = false
}