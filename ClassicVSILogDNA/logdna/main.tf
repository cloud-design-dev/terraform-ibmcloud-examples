resource ibm_resource_instance logdna_instance {
  name              = var.name
  service           = "logdna"
  plan              = var.plan
  location          = var.region
  resource_group_id = data.ibm_resource_group.group.id
  tags              = ["logdna", "region:${var.region}"]
}

resource ibm_resource_key logdna_key {
  name                 = "${var.name}-service-key"
  role                 = "Administrator"
  resource_instance_id = ibm_resource_instance.logdna_instance.id
}