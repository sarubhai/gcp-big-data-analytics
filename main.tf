# main.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the infrastructure resources for GCP Big Data Analytics

# VPC & Subnets
module "vpc" {
  source          = "./vpc"
  prefix          = var.prefix
  owner           = var.owner
  project_id      = var.project_id
  region          = var.region
  zone            = var.zone
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

# Cloud Storage
module "cloudstorage" {
  source     = "./cloudstorage"
  prefix     = var.prefix
  owner      = var.owner
  project_id = var.project_id
  region     = var.region
}

# BigQuery
module "bigquery" {
  source                 = "./bigquery"
  prefix                 = var.prefix
  owner                  = var.owner
  project_id             = var.project_id
  region                 = var.region
  cs_datagen_bucket_name = module.cloudstorage.cs_datagen_bucket_name
  depends_on = [
    module.cloudstorage.google_storage_bucket_object
  ]
}
