data "ibm_compute_ssh_key" "ssh" {
  label = var.ssh_key
}