output "primary_network_interface" {
  value = ibm_is_instance.minio.primary_network_interface[0].id
}
