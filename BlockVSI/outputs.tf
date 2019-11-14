resource "local_file" "output" {
  content = <<EOF
CONNECTION_INFO="${jsonencode(ibm_storage_block.blocktest.allowed_host_info)}"
EOF

  filename = "./outputs.env"
}
