variable project_name {
  description = ""
  type        = string
  default     = ""
}

variable region {
  description = "The IBM Cloud Region where the VPC will be deployed. Current options: [au-syd, eu-de, eu-gb, jp-tok, us-east, us-south]"
  type        = string
  default     = ""
}

variable resource_group {
  description = "The Resource group with the correct permissions to deploy VPC resources."
  type        = string
  default     = ""
}

variable tags {
  description = "Tags to add to deployed resources."
  type        = list
  default     = ["terraform", "ryantiffany"]
}

variable subnet_cidr {
  description = ""
  default     = []
}

variable address_count {
  default = 32
}
variable instance_count {
  default = "3"
}

variable ssh_key {
}
