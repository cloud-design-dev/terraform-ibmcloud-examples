output "subnet_id" {
  value = ibm_is_subnet.subnet[*].id
}

output "cidr" {
  value = ibm_is_subnet.subnet.*.ipv4_cidr_block
}