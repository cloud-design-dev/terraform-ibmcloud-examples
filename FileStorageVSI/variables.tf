variable public_vlan {
  type = "string"
  default = ""
}

variable private_vlan {
  type = "string"
  default = ""
}

variable domain {
  default = "example.com"
}

variable datacenter {
  type = "string"
  default = ""
}

variable vm_flavor {
  default = "B1_2X4X100"
}

variable os {
  default = "UBUNTU_LATEST_64"
}