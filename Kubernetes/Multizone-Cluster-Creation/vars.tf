# IBM Cloud PaaS API Key:
variable ibm_bx_api_key {}

# IBM Cloud IaaS User (aka SoftLayer Username)
variable ibm_sl_username {}

# IBM Cloud IaaS User API key (aka SoftLayer User Api Key)
variable ibm_sl_api_key {}

variable ibm_account_guid {}
variable ibm_org_guid {}
variable ibm_space_guid {}

variable zones {
    type = "list"
    default = ["wdc07","wdc04"]
}

variable private_vlans {
type = "list"
default = ["1892939", "2162809"]
}

variable public_vlans {
type = "list"
default = ["1892917", "2162807"]
}
