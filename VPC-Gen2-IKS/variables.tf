variable "resource_group_name" {
  description = "Resource group where resources will be deployed."
  type        = string
  default     = ""
}

variable "region" {
  description = "Region to use for VPC and IKS resources."
  type        = string
  default     = ""
}

variable "vpc_name" {
  description = "Name of the VPC."
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "Name of the IKS Cluster."
  type        = string
  default     = ""
}
