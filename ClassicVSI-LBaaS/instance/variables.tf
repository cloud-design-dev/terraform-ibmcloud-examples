variable "datacenter" {
  description = "Datacenter where instance and storage will be deployed."
  type        = string
  default     = ""
}

variable "instance_size" {
  description = "Size of classic instance."
  type        = string
  default     = "BL2_2X4X100"
}

variable "os_image" {
  description = "Operating System image for classic instance."
  type        = string
  default     = "UBUNTU_18_64"
}
variable instance_count {
  description = "Number of web server instances to deploy."
  type        = string
  default     = "3"
}

variable domain {
  description = "Default domain for web server instances."
  type        = string
  default     = "example.com"
}

variable "ssh_key" {
  description = "SSH key to add to instance."
  type        = string
  default     = ""
}