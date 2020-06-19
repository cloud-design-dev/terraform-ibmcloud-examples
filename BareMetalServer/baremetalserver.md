# Bare Metal Server

The following example will deploy a montly Bare Metal server to the IBM Cloud using Terraform.

First copy the template file for our credentials

```text
$ cp ../credentials.tfvars.tmpl ../credentials.tfvars
```

Update the `../credentials.tfvars` with your SoftLayer username, API key and your IBM Cloud API Key

#### Code

```text
resource "ibm_compute_bare_metal" "monthly_bm1" {

# Mandatory fields
    package_key_name = "DUAL_E52600_V4_12_DRIVES"
    process_key_name = "INTEL_INTEL_XEON_E52620_V4_2_10"
    memory = 64
    os_key_name = "OS_UBUNTU_16_04_LTS_XENIAL_XERUS_64_BIT"
    hostname = "cust-bm"
    domain = "ms.com"
    datacenter = "${var.datacenter}"
    network_speed = 10000
    public_bandwidth = 500
    disk_key_names = [ "HARD_DRIVE_800GB_SSD", "HARD_DRIVE_800GB_SSD", "HARD_DRIVE_800GB_SSD" ]
    hourly_billing = false

# Optional fields
    private_network_only = false
    unbonded_network = true
    public_vlan_id = "${var.pub_vlan}"
    private_vlan_id = "${var.priv_vlan}"
    tags = [
      "ryan",
      "testing"
    ]
    redundant_power_supply = true
    storage_groups = {
       # RAID 5
       array_type_id = 3
       # Use three disks
       hard_drives = [ 0, 1, 2]
       array_size = 1600
       # Basic partition template for Linux
       partition_template_id = 1
    }
}
```

#### Plan and Apply

```text
$ terraform init
$ terraform plan -var-file='../credentials.tfvars' -out bmtest.tfplan
$ terraform apply bmtest.tfplan
```

