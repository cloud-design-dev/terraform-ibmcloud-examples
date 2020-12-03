output floating_ip {
  value = ibm_is_floating_ip.ip.address
}

output instance_1_record {
  value = "${ibm_is_instance.instance[0].name}.${var.domain}"
}

output instance_2_record {
  value = "${ibm_is_instance.instance[1].name}.${var.domain}"
}