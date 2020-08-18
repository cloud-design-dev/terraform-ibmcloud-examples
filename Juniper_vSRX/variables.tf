variable "datacenter" {
  description = "Datacenter where gateway appliances and VLANs will be deployed."
  type        = string
  default     = ""
}

variable "domainname" {
  description = "Domain name for gateway appliances."
  type        = string
  default     = ""
}

variable "iaas_classic_username" {
  description = "Classic IaaS username."
  type        = string
  default     = ""
}

variable "iaas_classic_api_key" {
  description = "Classic IaaS API Key."
  type        = string
  default     = ""
}

variable "ssh_key" {
  description = "SSH key to add to gateway appliances."
  type        = string
  default     = ""
}