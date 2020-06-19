variable "datacenter" {
  description = "The datacenter where the instance will be deployed."
  type        = string
  default     = "wdc07"
}

variable "private_vlan_id" {
  description = "Private VLAN where instance will be deployed."
  type        = string
  default     = ""
}

variable "public_vlan_id" {
  description = "Private VLAN where instance will be deployed."
  type        = string
  default     = ""
}

variable "domain" {
  description = "Private VLAN where instance will be deployed."
  type        = string
  default     = ""
}

