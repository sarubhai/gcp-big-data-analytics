# Name: vpc.tf
# Owner: Saurav Mitra
# Description: This terraform config will create a VPC with following resources:
#   3 Private Subnets
#   3 Public Subnets
#   1 NAT Gateway
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
  private_ip_google_access = false
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

# Cloud Router
resource "google_compute_router" "router" {
  project     = var.project_id
  name        = "${var.prefix}-router"
  description = "${var.prefix}-router"
  region      = var.region
  network     = google_compute_network.vpc.id
}

# NAT Gateway
resource "google_compute_router_nat" "natgw" {
  project                            = var.project_id
  name                               = "${var.prefix}-natgw"
  region                             = var.region
  router                             = google_compute_router.router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.private_subnets.0.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  subnetwork {
    name                    = google_compute_subnetwork.private_subnets.1.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  subnetwork {
    name                    = google_compute_subnetwork.private_subnets.2.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

# Default Firewall
resource "google_compute_firewall" "fw_default" {
  project     = var.project_id
  name        = "${var.prefix}-fw-default"
  description = "${var.prefix}-fw-default"
  network     = google_compute_network.vpc.name
  priority    = 10000

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  #  target_tags = ["bda"]
}
