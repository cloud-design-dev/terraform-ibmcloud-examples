# generate a property file suitable for shell scripts with useful variables relating to the environment
resource "local_file" "output" {
  content = <<EOF
NODE0__ID=${ibm_compute_vm_instance.node[0].id}
NODE0_PUBLIC_IP=${ibm_compute_vm_instance.node[0].ipv4_address}
LBAAS_IP=${ibm_lbaas.lbaas.vip}
EOF


  filename = "${path.module}/${terraform.workspace}.env"
}

