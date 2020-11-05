variable ibmcloud_api_key {
  description = "IBM Cloud API key used to deploy LogDNA instance"
  type        = string
  default     = ""
}

variable region {
  description = "The region where the VPC resources and ICOS buckets will be deployed."
  type        = string
  default     = ""
}

variable name {
  description = "Name that will be added to all deployed resources."
  type        = string
  default     = ""
}

variable resource_group {
  description = "Resource groups for deployed assets."
  type        = string
  default     = ""
}

variable "ibmcloud_timeout" {
  description = "The number of seconds that you want to wait until the IBM Cloud API is considered unavailable. The default value is 60."
  type        = number
  default     = 900
}

variable ssh_key {
  description = "SSH key that will be added to the VPC compute instance."
  type        = string
  default     = ""
}

variable tags {
  default = ["terraform"]
}
