# IBM Cloud PaaS API Key:
variable "ibm_bx_api_key" {
}

# IBM Cloud IaaS User (aka SoftLayer Username)
variable "ibm_sl_username" {
}

# IBM Cloud IaaS User API key (aka SoftLayer User Api Key)
variable "ibm_sl_api_key" {
}

variable "ibm_account_guid" {
}

variable "ibm_org_guid" {
}

variable "ibm_resource_group_id" {
}

variable "datacenter" {
  type = map(string)

  default = {
    us-east1  = "wdc04"
    us-east2  = "wdc06"
    us-east3  = "wdc07"
    us-south1 = "dal10"
    us-south2 = "dal12"
    us-south3 = "dal13"
  }
}

variable "vm_flavor" {
  type = map(string)

  default = {
    small = "b2c.4x16"
    large = "b2c.16x64"
  }
}

variable "priv_vlan" {
  type = map(string)

  default = {
    us-east1  = "xxxxxxx"
    us-east2  = "xxxxxxx"
    us-east3  = "xxxxxxx"
    us-south1 = "xxxxxxx"
    us-south2 = "xxxxxxx"
    us-south3 = "xxxxxxx"
  }
}

variable "pub_vlan" {
  type = map(string)

  default = {
    us-east1  = "xxxxxxx"
    us-east2  = "xxxxxxx"
    us-east3  = "xxxxxxx"
    us-south1 = "xxxxxxx"
    us-south2 = "xxxxxxx"
    us-south3 = "xxxxxxx"
  }
}

variable "domainname" {
  default = "example.com"
}

