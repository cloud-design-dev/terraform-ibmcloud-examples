variable datacenter {}
variable "storage_iops" {
  description = "IOPs for storage volume."
  type        = string
  default     = "2"
}

variable "storage_size" {
  description = "Size for storage volume in GB."
  type        = string
  default     = "2000"
}