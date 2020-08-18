variable "domain" {
  description = "Domain to use with instance."
  default     = "example.com"
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
  default     = "UBUNTU_LATEST_64"
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

variable "storage_iops" {
  description = "IOPs for storage volume."
  type        = string
  default     = ""
}

variable "storage_size" {
  description = "Size for storage volume."
  type        = string
  default     = ""
}

variable "ssh_key" {
  description = "SSH key to add to instance."
  type        = string
  default     = ""
}

