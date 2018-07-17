<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Security Group Example](#security-group-example)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Security Group Example

This example relies on [v0.6](https://github.com/IBM-Bluemix/terraform-provider-ibm/releases/tag/v0.6.0) of the IBM Cloud Provider plugin for Terraform. 

In this simple example I am creating a new Security group to resrict public SSH access to my home IP, my work IP, and the IP of a jumpbox I use when I am not at home or work. For obvious reasons I have substituted the real IPs with some from the 192.x private range. 