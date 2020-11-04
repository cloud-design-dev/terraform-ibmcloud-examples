variable "zones" {
  description = "Zones in the VPC region."
  type        = list
  default     = []
}

variable "resource_group" {
  description = "Resource group ID."
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "VPC ID."
  type        = string
  default     = ""
}

variable "vpc" {
  description = "VPC Name."
  type        = string
  default     = ""
}
