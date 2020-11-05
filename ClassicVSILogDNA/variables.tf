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

variable ibmcloud_api_key {
  description = "IBM Cloud API key used to deploy LogDNA instance"
  type        = string
  default     = ""
}

variable ssh_key {
  description = "SSH key to add to instance."
  type        = string
  default     = ""
}

variable datacenter {
  description = "Datacenter where classic VSI will be deployed."
  type        = string
  default     = ""
}

variable region {
  description = "Region where LogDNA instance will be deployed."
  type        = string
  default     = ""
}

variable resource_group {
  default = ""
}