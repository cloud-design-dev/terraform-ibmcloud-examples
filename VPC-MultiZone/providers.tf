provider "ibm" {
  region           = var.region
  generation       = 2
  ibmcloud_timeout = var.ibmcloud_timeout
}
