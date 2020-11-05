output subnet_id {
  value = ibm_compute_vm_instance.instance[0].private_subnet_id
}

output ips {
  value = ibm_compute_vm_instance.instance[*].ipv4_address_private
}