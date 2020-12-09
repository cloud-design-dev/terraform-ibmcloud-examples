output instance {
  value = ibm_is_instance.minio
}

output floating_ip {
  value = ibm_is_floating_ip.bastion.address
}