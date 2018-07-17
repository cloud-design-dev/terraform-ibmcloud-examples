# Softlayer username
variable slusername {}

# SoftLayer API key
variable slapikey {}

# The target operating system for the web nodes
variable os {
  default = "CENTOS_6_64"
}

# The number of cores each web virtual guest will recieve
variable vm_cores {
  default = 2
}
# The amount of memory each web virtual guest will recieve
variable vm_memory {
  default = 4096
}

# The datacenter to deploy to
variable datacenter {
 default = "hou02"
}

# vlan 1382
# The private vlan to deploy the virtual guests on to
variable vra1priv_vlan {
 default = 1330103
}

# vlan 1336
variable vra1pub_vlan {
 default = 1330093
}

# vlan 1425
# The private vlan to deploy the virtual guests on to
variable vra2priv_vlan {
 default = 898243
}

# vlan 1595
variable vra2pub_vlan {
 default = 898241
}

# The domain name for the virtual guests
variable domainname {
 default = "cde.services"
}