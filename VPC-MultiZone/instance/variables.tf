variable subnet_id {}
variable name {}
variable vpc {}
variable resource_group_id {}

variable ssh_key_ids {}
variable image_name {
  default = "ibm-ubuntu-18-04-1-minimal-amd64-2"
}
variable profile_name {
  default = "cx2-2x4"
}
variable security_group {}
variable tags {}

variable zone {}