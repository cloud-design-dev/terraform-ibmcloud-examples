resource "local_file" "ansible-inventory" {
  content = templatefile("${path.module}/templates/inventory.tmpl",
    {
      instances  = var.instances
      bastion_ip = var.bastion_ip
    }
  )
  filename = "${path.module}/inventory"
}

resource "local_file" "ansible_inventory_vars" {
  content = templatefile("${path.module}/templates/deployment_vars.tmpl",
    {
      access_key = var.access_key
      secret_key = var.secret_key
    }
  )
  filename = "${path.module}/playbooks/deployment_vars.yml"
}

resource "local_file" "ansible-config" {
  content = templatefile("${path.module}/templates/ansible.cfg.tmpl",
    {
      bastion_ip = var.bastion_ip
    }
  )
  filename = "${path.module}/ansible.cfg"

  # to make sure the directory is not writable by other
  # so that Ansible does not complain on Windows
  provisioner "local-exec" {
    command = "chmod o-w ${path.module}"
  }
}