# Softlayer username
variable slusername {}

# SoftLayer API key
variable slapikey {}

# The target operating system for the VRA

variable os {
  default = "OS_VYATTA_5600_5_X_UP_TO_1GBPS_SUBSCRIPTION_EDITION_64_BIT"
}

# The amount of memory for the VRA
variable vra_memory {
  default = 16384
}

# The datacenter to deploy to
variable datacenter {
 default = "dal13"
}

# [OPTIONAL] Uncomment to set the private vlan to deploy the VRA on to. If you uncomment this
# you also need to uncomment the line `private_vlan_id` in the `main.tf` file. 
#variable priv_vlan {
# default = YOUR_PRIVATE_VLAN_ID
#}

# [OPTIONAL] Uncomment to set the public vlan to deploy the VRA on to. If you uncomment this
# you also need to uncomment the line `public_vlan_id` in the `main.tf` file. 
#variable pub_vlan {
# default = YOUR_PUBLIC_VLAN_ID
#}

# The domain name for the VRA
variable domainname {
 default = "YOURDOMAIN.COM"