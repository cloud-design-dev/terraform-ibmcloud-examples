// output "hostname" {
//   value = "${ibm_storage_block.blocktest.hostname}"
// }

// output "volumename" {
//   value = "${ibm_storage_block.blocktest.volumename}"
// }

// output "allowed_host_info" {
//   value = "${ibm_storage_block.blocktest.allowed_host_info}"
// }

resource "local_file" "output" {
  content = <<EOF
CONNECTION_INFO="${jsonencode(ibm_storage_block.blocktest.allowed_host_info)}"
EOF

  filename = "./outputs.env"
}