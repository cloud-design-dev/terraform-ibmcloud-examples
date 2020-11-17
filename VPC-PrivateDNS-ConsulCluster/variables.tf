variable ibmcloud_api_key {
  description = "IBM Cloud API key used to deploy VPC resources."
  type        = string
  default     = ""
}

variable "region" {
  type        = string
  description = "The region where the VPC resources will be deployed."
  default     = ""
}

variable "resource_group" {
  default = ""
}

variable "ssh_key" {
  default = ""
}

variable "ibmcloud_timeout" {
  default = 900
}

variable "project_name" {
  description = "The project name is used to name the cluster with the environment name"
  default     = ""
}
variable "owner" {
  description = "Use your user name or team name. The owner is used to label the cluster and other resources"
  default     = ""
}

variable "environment" {
  default     = "dev"
  description = "The environment name is used to name the cluster with the project name"
}

variable "consul_security_group" {}

variable "vpc_name" {}

variable "tags" {
  default = ["ryantiffany", "terraform"]
}

variable pdns_instance_id {

}

variable "internal_security_group" {}

variable "acl_token" {}
variable "encrypt_key" {}