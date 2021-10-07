# Name: provider.tf
# Owner: Saurav Mitra
# Description: This terraform config will Configure Terraform Providers
# https://www.terraform.io/docs/language/providers/requirements.html

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.0"
    }
  }
}

# Configure Terraform Google Provider
# https://registry.terraform.io/providers/hashicorp/google/latest/docs

# $ export GOOGLE_APPLICATION_CREDENTIALS="/Users/John/gcloud-config-credentials.json"

provider "google" {
  # Configuration options
  # credentials = var.google_application_credentials
  project = var.project_id
  region  = var.region
}
