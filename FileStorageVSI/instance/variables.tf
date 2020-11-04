variable ssh_key {}
variable datacenter {}
variable mountpoint {}
variable storage_id {}

variable "os_image" {
  description = "Operating System image for classic instance."
  type        = string
  default     = "UBUNTU_18_64"
}

variable "instance_size" {
  description = "Size of classic instance."
  type        = string
  default     = "B1_2X4X100"
}

variable domain {
  default = "example.com"
}