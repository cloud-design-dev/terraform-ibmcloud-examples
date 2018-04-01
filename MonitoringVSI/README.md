# VSI with IBM Cloud Monitoring

This example will deploy an instance of the [IBM Cloud Monitoring](https://console.bluemix.net/docs/services/cloud-monitoring/index.html#getting-started-with-ibm-cloud-monitoring) service as well as an IBM Cloud VSI. The postinstall script will then configure the VSI to send metrics to the monitoring service via collectd.

*Note: for this example to work you need to ensure you have the bx cli installed and you are logged in to your account. See [here](https://developer.ibm.com/courses/labs/1-install-bluemix-command-line-interface-cli-dwc020/) for assistance with the bx CLI*