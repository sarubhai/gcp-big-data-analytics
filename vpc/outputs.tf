# Name: outputs.tf
# Owner: Saurav Mitra
# Description: Outputs the VPC & Subnet IDs

output "vpc_id" {
  value       = google_compute_network.vpc.id
  description = "The VPC ID."
}

output "vpc_name" {
  value       = google_compute_network.vpc.name
  description = "The VPC Name."
}

output "public_subnet_id" {
  value       = google_compute_subnetwork.public_subnets.*.id
  description = "The public subnets ID."
}

output "public_subnet_name" {
  value       = google_compute_subnetwork.public_subnets.*.name
  description = "The public subnets Name."
}

output "private_subnet_id" {
  value       = google_compute_subnetwork.private_subnets.*.id
  description = "The private subnets ID."
}

output "private_subnet_name" {
  value       = google_compute_subnetwork.private_subnets.*.name
  description = "The private subnets Name."
}
