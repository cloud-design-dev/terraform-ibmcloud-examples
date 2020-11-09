variable ibmcloud_api_key {
  description = "IBM Cloud API key."
  type        = string
  default     = ""
}

variable resource_group {}

variable ibmcloud_timeout {
  default = 900
}

variable domain {}

variable origin_pool_ips {
  default = ["192.168.0.5", "172.16.0.5", "10.240.0.5"]
}

variable name {}

variable enabled {
  default = true
}