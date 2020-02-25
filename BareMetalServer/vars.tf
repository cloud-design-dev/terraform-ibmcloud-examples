# The datacenter to deploy to
variable "datacenter" {
  default = "wdc07"
}

variable "private_vlan_id" {
  type    = string
  default = ""
}

variable "public_vlan_id" {
  type    = string
  default = ""
}

variable "domain" {
  type    = string
  default = ""
}

