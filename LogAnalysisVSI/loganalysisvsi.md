# VSI and Log Analysis Example

This example creates an instance of the [Log Analysis](https://console.bluemix.net/catalog/services/log-analysis?taxonomyNavigation=apps) service, deploys a VSI and then configures the VSI to use the Log Analysis service.

You will need to edit the `vars.tf` file and replace the following default items \(at minimum\):

* priv\_vlan
* pub\_vlan
* domainname

You will also need to edit the `main.tf` to use your Terraform box ssh key.

