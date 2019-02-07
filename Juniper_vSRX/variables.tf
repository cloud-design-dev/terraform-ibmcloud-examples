# IBM Cloud PaaS API Key:
variable ibm_bx_api_key {}

# IBM Cloud IaaS User (aka SoftLayer Username)
variable ibm_sl_username {}

# IBM Cloud IaaS User API key (aka SoftLayer User Api Key)
variable ibm_sl_api_key {}

variable datacenter {
  type = "map"

  default = {
    "us-east1"  = "wdc04"
    "us-east2"  = "wdc06"
    "us-east3"  = "wdc07"
    "us-south1" = "dal10"
    "us-south2" = "dal12"
    "us-south3" = "dal13"
  }
}

variable "priv_vlan" {
  type = "map"

  default = {
    "us-east1"  = "2162809"
    "us-east2"  = "1669323"
    "us-east3"  = "2463707"
    "us-south1" = "1286783"
    "us-south2" = "1535681"
    "us-south3" = "1583617"
  }
}

variable "pub_vlan" {
  type = "map"

  default = {
    us-east1  = "2162807"
    us-east2  = "2508931"
    us-east3  = "2463705"
    us-south1 = "1286781"
    us-south2 = "1535671"
    us-south3 = "1583615"
  }
}

variable "domainname" {
  default = "example.com"
}

