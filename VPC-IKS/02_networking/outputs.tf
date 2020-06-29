output "zone_subnet_ids" {
  value = [ibm_is_subnet.z1_iks_subnet.id, ibm_is_subnet.z2_iks_subnet.id, ibm_is_subnet.z3_iks_subnet.id]
}