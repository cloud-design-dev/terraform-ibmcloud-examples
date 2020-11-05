variable "coscreds" {
  type = "map"

  default = {
    "HMAC" = true
  }
}

data "ibm_org" "orgData" {
  org = "${var.ibm_bmx_org}"
}

data "ibm_account" "accountData" {
  org_guid = "${data.ibm_org.orgData.id}"
}

data "ibm_space" "spaceData" {
  space = "${var.ibm_bmx_space}"
  org   = "${var.ibm_bmx_org}"
}

resource "ibm_service_instance" "cos" {
  name       = "tfcostest"
  space_guid = "${data.ibm_space.spaceData.id}"
  service    = "cloud-object-storage"
  plan       = "Lite"
}

resource "ibm_service_key" "serviceKey" {
  name = "coskey"

  parameters = "${var.coscreds}"

  service_instance_guid = "${ibm_service_instance.cos.id}"

  provisioner "local-exec" {
    command = "rm -f tfcostest.out"
  }

  provisioner "local-exec" {
    command = "bx service key-show tfcostest coskey > tfcostest.out"
  }
}

