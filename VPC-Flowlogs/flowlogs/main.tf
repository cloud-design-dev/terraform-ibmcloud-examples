resource "ibm_iam_authorization_policy" "flowlogs_policy" {
  source_service_name         = "is"
  source_resource_type        = "flow-log-collector"
  target_service_name         = "cloud-object-storage"
  target_resource_instance_id = var.cos_id
  roles                       = ["Reader", "Writer"]
}

resource ibm_is_flow_log vpc_flowlog {
  depends_on     = [ibm_iam_authorization_policy.flowlogs_policy]
  name           = "${var.name}-vpc-flow-log"
  target         = var.vpc_id
  active         = true
  storage_bucket = var.vpc_bucket
  resource_group = data.ibm_resource_group.group.id
  tags           = concat(var.tags, ["vpc-flowlogs"])
}

resource ibm_is_flow_log subnet_flowlog {
  depends_on     = [ibm_is_flow_log.vpc_flowlog]
  name           = "${var.name}-subnet-flow-log"
  target         = var.subnet_id
  active         = true
  storage_bucket = var.subnet_bucket
  resource_group = data.ibm_resource_group.group.id
  tags           = concat(var.tags, ["subnet-flowlogs"])
}