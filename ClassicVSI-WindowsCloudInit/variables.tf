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

variable "domain" {
  description = "Domain to use with instance."
  default     = "cdetesting.com"
}

variable "datacenter" {
  description = "Datacenter where instance and storage will be deployed."
  type        = string
  default     = ""
}

variable "instance_size" {
  description = "Size of classic instance."
  type        = string
  default     = "BL2_4X16X100"
}

variable "os_image" {
  description = "Operating System image for classic instance."
  type        = string
  default     = "WIN_2019-STD_64"
}

