variable "zones" {
  description = ""
  type        = list
  default     = []
}

variable "resource_group" {
  description = ""
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = ""
  type        = string
  default     = ""
}

variable "iks_subnets" {
  description = ""
  default     = ""
}

variable "cluster_name" {
  description = ""
  type        = string
  default     = ""
}

variable "flavor" {
  description = "Machine flavor size"
  default     = "bx2.4x16"
  type        = string
}