variable name {}
variable zone {}
variable subnet {}
variable vpc {}
variable resource_group {}

variable ssh_key {}
variable profile_name {
  default = "cx2-2x4"
}

variable image_name {
  default = "ibm-ubuntu-20-04-minimal-amd64-2"
}

variable internal_security_group {}
variable consul_security_group {}

variable consul_version {
  default = "1.7.9"
}
variable encrypt_key {}
variable acl_token {}
variable "tags" {}
