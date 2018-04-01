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

resource "ibm_service_instance" "monitoring" {
  name       = "tfmonitoring"
  space_guid = "${data.ibm_space.spaceData.id}"
  service    = "Monitoring"
  plan       = "premium"

  provisioner "local-exec" {
    command = "bx iam api-key-create tfmonitoring -d 'API for Cloud Monitoring' -f tfmonitoring.key"
  }

  provisioner "local-exec" {
    command = "bx iam space dev --guid > space.id"
  }
}
