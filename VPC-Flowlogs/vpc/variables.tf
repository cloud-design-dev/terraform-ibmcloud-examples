
variable resource_group {}

variable name {}

variable tags {}

variable ssh_key {}

variable region {}

variable image_name {
  default = "ibm-ubuntu-18-04-1-minimal-amd64-2"
}
variable profile_name {
  default = "cx2-2x4"
}