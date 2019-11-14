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

variable "domainname" {
  default = "example.com"
}

