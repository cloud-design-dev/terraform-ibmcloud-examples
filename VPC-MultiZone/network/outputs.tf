output "subnet_id" {
  value = ibm_is_subnet.subnet.*.id
}

output bastion_sg {
  value = ibm_is_security_group.bastion_sg.id
}

output bastion_sg2 {
  value = "${var.name}-bastion-sg"
}

output instance_sg {
  value = ibm_is_security_group.instance_sg.id
}

output instance_sg2 {
  value = "${var.name}-instance-sg"
}