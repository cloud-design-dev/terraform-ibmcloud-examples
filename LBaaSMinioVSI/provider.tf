provider "ibm" {
  iaas_classic_username = var.iaas_classic_username
  iaas_classic_api_key  = var.iaas_classic_api_key
}

provider "dnsimple" {
  token   = var.dnsimple_token
  account = var.dnsimple_account
}

