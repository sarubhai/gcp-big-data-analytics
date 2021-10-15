# main.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the Big Query Dataset

resource "google_bigquery_dataset" "ds_gcp_bda" {
  project                     = var.project_id
  location                    = var.region
  dataset_id                  = "ds_gcp_bda"
  friendly_name               = "ds-gcp-bda"
  description                 = "gcp big data analytics dataset"
  default_table_expiration_ms = 3600000
  delete_contents_on_destroy  = true

  labels = {
    name    = "ds-gcp-bda"
    owner   = var.owner
    project = var.prefix
  }
}
