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
variable datacenter1 {
 default = "dal13"
}

# number : 1334
# gw/cidr : 10.186.187.65/26
# The private vlan to deploy the virtual guests on to
variable dal13priv_vlan {
 default = 2159525
}

# number : 1266
# gw/cidr : 169.48.75.81/28
variable dal13pub_vlan {
 default = 2159523
}

# The second datacenter to deploy to
variable datacenter2 {
 default = "wdc07"
}

# number : 883
# gw/cidr : 10.190.37.129/26
# The private vlan to deploy the virtual guests on to
variable wdc07priv_vlan {
 default = 1892939
}

# number : 849
# gw/cidr : 169.61.93.65/28
variable wdc07pub_vlan {
 default = 1892917
}

# The domain name for the virtual guests/gateways
variable domainname {
 default = "cde.services"
}