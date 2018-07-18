# IBM Cloud PaaS API Key:
variable ibm_bx_api_key {}

# IBM Cloud IaaS User (aka SoftLayer Username)
variable ibm_sl_username {}

# IBM Cloud IaaS User API key (aka SoftLayer User Api Key)
variable ibm_sl_api_key {}

# The datacenter to deploy to
variable datacenter {
  default = "wdc07"
}

variable priv_vlan { 
  default = 1892939
}

variable pub_vlan { 
  default = 1892917
}

# The domain name for the virtual guests
variable domainname { 
  default = "cde.services"
}
