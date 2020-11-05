data "ibm_compute_ssh_key" "ssh_key" {
  label = var.ssh_key
}

data "ibm_security_group" "allow_http" {
  name = "allow_http"
}

data "ibm_security_group" "allow_outbound" {
  name = "allow_outbound"
}

data "ibm_security_group" "allow_ssh" {
  name = "allow_ssh"
}