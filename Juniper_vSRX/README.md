# Deploy an HA Juniper vSRX via Terraform
This example will deploy a new public VLAN, a new private VLAN and a new HA vSRX environment to protect the new VLANs.

If you would like to also set the new VLANs to be `Routed Through` the new vSRX deployment you can also add the following code to `main.tf`.

```hcl
resource "ibm_network_gateway_vlan_association" "public_gateway_vlan_association" {
  depends_on      = ["ibm_network_gateway.ha_vsrx"]
  gateway_id      = "${ibm_network_gateway.ha_vsrx.id}"
  network_vlan_id = "${ibm_network_vlan.ha_srx_public_vlan.id}"
}

resource "ibm_network_gateway_vlan_association" "private_gateway_vlan_association" {
  depends_on      = ["ibm_network_gateway.ha_vsrx"]
  gateway_id      = "${ibm_network_gateway.ha_vsrx.id}"
  network_vlan_id = "${ibm_network_vlan.ha_srx_private_vlan.id}"
}
```

If you have existing VLANs that you want to protect with the HA vSRX environment the `main.tf` file would look like this:

```
data "ibm_network_vlan" "ha_srx_public_vlan" {
   name = "ha_srx_public_vlan"
}

data "ibm_network_vlan" "ha_srx_private_vlan" {
   name = "ha_srx_private_vlan"
}

resource "ibm_network_gateway" "ha_vsrx" {
  name = "ha-srx-us-south"

  members = [{
    hostname               = "ha1-srx-dal13"
    domain                 = "${var.domainname}"
    datacenter             = "${var.datacenter["us-south3"]}"
    network_speed          = 10000
    private_network_only   = false
    tcp_monitoring         = true
    package_key_name       = "VIRTUAL_ROUTER_APPLIANCE_10_GPBS"
    process_key_name       = "INTEL_INTEL_XEON_5120_2_20"
    os_key_name            = "OS_JUNIPER_VSRX_15_X_UP_TO_10_GBPS_STANDARD"
    redundant_network      = false
    disk_key_names         = ["HARD_DRIVE_2_00_TB_SATA_2"]
    redundant_power_supply = true
    public_bandwidth       = 20000
    memory                 = 32
    public_vlan_id         = "${data.ibm_network_vlan.ha_srx_public_vlan.id}"
    private_vlan_id        = "${data.ibm_network_vlan.ha_srx_private_vlan.id}"
    tags                   = ["vsrx-ha-node1"]
    notes                  = "testing the deployment of an srx via terraform"
    ipv6_enabled           = true
  },
  {
    hostname               = "ha2-srx-dal13"
    domain                 = "${var.domainname}"
    datacenter             = "${var.datacenter["us-south3"]}"
    network_speed          = 10000
    private_network_only   = false
    tcp_monitoring         = true
    package_key_name       = "VIRTUAL_ROUTER_APPLIANCE_10_GPBS"
    process_key_name       = "INTEL_INTEL_XEON_5120_2_20"
    os_key_name            = "OS_JUNIPER_VSRX_15_X_UP_TO_10_GBPS_STANDARD"
    redundant_network      = false
    disk_key_names         = ["HARD_DRIVE_2_00_TB_SATA_2"]
    redundant_power_supply = true
    public_bandwidth       = 20000
    memory                 = 32
    public_vlan_id         = "${data.ibm_network_vlan.ha_srx_public_vlan.id}"
    private_vlan_id        = "${data.ibm_network_vlan.ha_srx_private_vlan.id}"
    tags                   = ["vsrx-ha-node2"]
    notes                  = "testing the deployment of an srx via terraform"
    ipv6_enabled           = true
    },
  ]
}
```

If you do not know the `name` of your VLANs or if you need to name them before you import them in Terraform you can do this from the customer portal at: https://cloud.ibm.com/classic/network/vlans.