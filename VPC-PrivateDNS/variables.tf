variable tags {
  default = ["terraform", "ryantiffany"]
}
variable project_name {}
variable ssh_key {}
variable region {}
variable image {
  default = "ibm-ubuntu-20-04-minimal-amd64-2"
}
variable profile {
  default = "cx2-2x4"
}

variable address_count {
  default = "32"
}

variable resource_group {}

variable ibmcloud_api_key {}

variable ibmcloud_timeout {
    default = 900
}

variable domain {
    default = "cde.local"
}

variable "instance_count" {
    default = 2
}