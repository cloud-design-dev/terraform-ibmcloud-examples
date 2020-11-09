output "id" {
  value = ibm_is_vpc.vpc.id
}

output "vpc_default_acl" {
  value = ibm_is_network_acl.network_acl.id
}

output "default_security_group" {
  value = ibm_is_vpc.vpc.default_security_group
}