variable ssh_key {}
variable name {}
variable vpc {}
variable image_name { default = "ibm-ubuntu-20-04-minimal-amd64-2" }
variable image_profile { default = "cx2-2x4" }
data ibm_is_ssh_key key { name = var.ssh_key }
