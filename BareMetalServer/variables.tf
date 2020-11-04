variable datacenter {
  description = "The datacenter where the instance will be deployed."
  type        = string
  default     = ""
}

variable private_vlan_id {
  description = "Private VLAN where instance will be deployed."
  type        = string
  default     = ""
}

variable public_vlan_id {
  description = "Private VLAN where instance will be deployed."
  type        = string
  default     = ""
}

variable domain {
  description = "Private VLAN where instance will be deployed."
  type        = string
  default     = "example.com"
}

variable iaas_classic_username {
  description = "Classic IaaS username."
  type        = string
  default     = ""
}

variable iaas_classic_api_key {
  description = "Classic IaaS API Key."
  type        = string
  default     = ""
}

variable os_image {
  type    = string
  default = "OS_UBUNTU_16_04_LTS_XENIAL_XERUS_64_BIT"
}

variable ssh_key {}