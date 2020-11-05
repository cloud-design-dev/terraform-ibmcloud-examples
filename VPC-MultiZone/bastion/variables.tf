variable subnet_id {}
variable name {}
variable vpc_id {}
variable resource_group_id {}

variable ssh_key_ids {}
variable image_name {
  default = "ibm-ubuntu-18-04-1-minimal-amd64-2"
}
variable profile_name {
  default = "cx2-2x4"
}

variable tags {}

variable zone {}

variable remote_ip {}

variable "subnets" {}
