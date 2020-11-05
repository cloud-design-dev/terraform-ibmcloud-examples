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
  default     = "B1_2X4X100"
}

variable "os_image" {
  description = "Operating System image for classic instance."
  type        = string
  default     = "UBUNTU_18_64"
}

variable storage_id {}
variable ssh_key {}
variable "sl_username" {}
variable "sl_apikey" {}
variable target_ip {}