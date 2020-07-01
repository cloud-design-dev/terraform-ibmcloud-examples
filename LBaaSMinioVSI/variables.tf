# IBM Cloud IaaS User (aka SoftLayer Username)
variable "iaas_classic_username" {
  decription = ""
  type       = string
  default    = ""
}

# IBM Cloud IaaS User API key (aka SoftLayer User Api Key)
variable "iaas_classic_api_key" {
  decription = ""
  type       = string
  default    = ""
}

variable "dnsimple_token" {
  decription = ""
  type       = string
  default    = ""
}

variable "dnsimple_account" {
  decription = ""
  type       = string
  default    = ""
}

variable "secret_key" {
  decription = ""
  type       = string
  default    = ""
}

variable "access_key" {
  decription = ""
  type       = string
  default    = ""
}

variable "count" {
  decription = ""
  type       = string
  default    = "4"
}

# The datacenter to deploy to
variable "datacenter" {
  decription = ""
  type       = string
  default    = ""
}

# The target operating system for the web nodes
variable "os" {
  default = "UBUNTU_LATEST_64"
}

# The domain name for the virtual guests
variable "domain" {
  default = "cde.services"
}

