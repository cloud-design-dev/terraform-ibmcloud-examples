output public_ip {
  value = ibm_compute_vm_instance.blockvsitest.ipv4_address
}