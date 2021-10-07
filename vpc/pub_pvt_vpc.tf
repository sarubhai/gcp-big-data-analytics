# Name: vpc.tf
# Owner: Saurav Mitra
# Description: This terraform config will create a VPC with following resources:
#   3 Private Subnets
#   3 Public Subnets
#   1 Firewall Rule (Access for Big Data Analytics bda tagged resources)

# VPC
resource "google_compute_network" "vpc" {
  project                         = var.project_id
  name                            = "${var.prefix}-vpc"
  description                     = "${var.prefix}-vpc"
  auto_create_subnetworks         = false
  routing_mode                    = "GLOBAL"
  delete_default_routes_on_create = false
}

# Public Subnet
resource "google_compute_subnetwork" "public_subnets" {
  count                    = length(var.public_subnets)
  project                  = var.project_id
  network                  = google_compute_network.vpc.id
  name                     = "${var.prefix}-public-subnet-${count.index}"
  description              = "${var.prefix}-public-subnet-${count.index}"
  ip_cidr_range            = var.public_subnets[count.index]
  region                   = var.region
  private_ip_google_access = true
}

# Private Subnet
resource "google_compute_subnetwork" "private_subnets" {
  count                    = length(var.private_subnets)
  project                  = var.project_id
  network                  = google_compute_network.vpc.id
  name                     = "${var.prefix}-private-subnet-${count.index}"
  description              = "${var.prefix}-private-subnet-${count.index}"
  ip_cidr_range            = var.private_subnets[count.index]
  region                   = var.region
  private_ip_google_access = true
}

# Bigdata Firewall
resource "google_compute_firewall" "fw_bda_access" {
  project     = var.project_id
  name        = "${var.prefix}-fw-bda-access"
  description = "${var.prefix}-fw-bda-access"
  network     = google_compute_network.vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags = ["bda"]
}
