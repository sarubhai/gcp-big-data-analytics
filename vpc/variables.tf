# variables.tf
# Owner: Saurav Mitra
# Description: Variables used by terraform config to create the infrastructure resources for GCP Big Data Analytics
# https://www.terraform.io/docs/configuration/variables.html

# Tags
variable "prefix" {
  description = "This prefix will be included in the name of the resources."
}

variable "owner" {
  description = "This owner name tag will be included in the owner of the resources."
}

# Google VPC
variable "project_id" {
  description = "The Project ID."
}

variable "region" {
  description = "The GCP Region."
}

variable "zone" {
  description = "The GCP Zone."
}

variable "private_subnets" {
  description = "A list of CIDR blocks to use for the private subnet."
}

variable "public_subnets" {
  description = "A list of CIDR blocks to use for the public subnet."
}
