# Softlayer username
variable slusername {}

# SoftLayer API key
variable slapikey {}

# The datacenter to deploy to
variable datacenter {
  default = "dal13"
}

# The target operating system for the web nodes
variable os {
  default = "UBUNTU_LATEST_64"
}

# The number of cores each web virtual guest will recieve
variable vm_cores {
  default = 1
}
# The amount of memory each web virtual guest will recieve
variable vm_memory {
  default = 2048
}

# The private vlan to deploy the virtual guests on to 
variable priv_vlan { 
  default = 1583617
}

# The public vlan to deploy the virtual guests on to 
variable pub_vlan { 
  default = 1583615
}

# The domain name for the virtual guests
variable domainname { 
  default = "cde.services"
}