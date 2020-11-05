variable name {
  description = "Name to prepend to resources"
  type        = string
  default     = ""
}

variable region {
  description = "Region where resources will be deployed"
  type        = string
  default     = ""
}

variable resource_group {
  description = "Resource group name. This will get imported as a data source."
  type        = string
  default     = ""
}

variable public_key {
  description = "Public SSH key fingerprint."
  type        = string
  default     = ""
}

variable profile_name {
  description = "Compute instance profile"
  type        = string
  default     = ""
}

variable image_name {
  description = "OS image name for compute instances."
  type        = string
  default     = ""
}

variable instance_count {
  description = "Number of compute instances to deploy. This will get imported as a data source"
  type        = string
  default     = "1"
}

variable tags {
  default = []
}

variable ibmcloud_timeout {
  description = "Default timeout for resources become available."
  default     = 900
}

variable remote_ip {
  description = "IP that is allowed to connect to the Floating (public) IP of your compute instance."
  type        = string
  default     = ""
}