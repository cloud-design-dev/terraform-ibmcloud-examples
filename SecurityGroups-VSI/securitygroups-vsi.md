# README

**Table of Contents** _generated with_ [_DocToc_](https://github.com/thlorenz/doctoc)

* [Security Group Example](securitygroups-vsi.md#security-group-example)

## Security Group Example

This example relies on [v0.6](https://github.com/IBM-Bluemix/terraform-provider-ibm/releases/tag/v0.6.0) of the IBM Cloud Provider plugin for Terraform.

In this simple example I am creating a new Security group to resrict public SSH access to my home IP, my work IP, and the IP of a jumpbox I use when I am not at home or work. For obvious reasons I have substituted the real IPs with some from the 192.x private range.

