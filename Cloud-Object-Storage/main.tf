resource ibm_resource_instance icos_instance {
  name              = var.name
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
  resource_group_id = data.ibm_resource_group.group.id
  tags              = ["tag1", "tag2"]

  parameters = {
    HMAC = true
  }
}

resource ibm_cos_bucket buckets {
  count                = length(var.environment)
  bucket_name          = "${var.name}-${var.environment[count.index]}-bucket"
  resource_instance_id = ibm_resource_instance.icos_instance.id
  region_location      = "us-east"
  storage_class        = "smart"
}