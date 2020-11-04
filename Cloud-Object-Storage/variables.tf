variable environment {
  default = ["dev", "qa", "prod"]
}

variable region {
  description = "The region where the ICOS buckets will be deployed."
  type        = string
  default     = ""
}

variable name {
  default = ""
}

variable resource_group {
  default = ""
}

variable "ibmcloud_timeout" {
  default = 900
}