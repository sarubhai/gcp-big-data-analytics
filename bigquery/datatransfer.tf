# main.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the Big Query Data Transfer Configs

# Customer
resource "google_bigquery_data_transfer_config" "customer_dtc" {
  project                = var.project_id
  location               = var.region
  destination_dataset_id = google_bigquery_dataset.ds_gcp_bda.dataset_id
  display_name           = "customer-dtc"
  data_source_id         = "google_cloud_storage"

  # schedule_options {
  #   disable_auto_scheduling = true
  # }

  params = {
    destination_table_name_template = google_bigquery_table.customer_tbl.table_id
    data_path_template              = "gs://${var.cs_datagen_bucket_name}/datasets/customer/customer.psv"
    write_disposition               = "APPEND"
    delete_source_files             = false
    file_format                     = "CSV"
    max_bad_records                 = 0
    ignore_unknown_values           = false
    field_delimiter                 = "|"
    skip_leading_rows               = 1
    allow_quoted_newlines           = false
    allow_jagged_rows               = false
  }
}

# Product
resource "google_bigquery_data_transfer_config" "product_dtc" {
  project                = var.project_id
  location               = var.region
  destination_dataset_id = google_bigquery_dataset.ds_gcp_bda.dataset_id
  display_name           = "product-dtc"
  data_source_id         = "google_cloud_storage"

  # schedule_options {
  #   disable_auto_scheduling = true
  # }

  params = {
    destination_table_name_template = google_bigquery_table.product_tbl.table_id
    data_path_template              = "gs://${var.cs_datagen_bucket_name}/datasets/product/product.psv"
    write_disposition               = "APPEND"
    delete_source_files             = false
    file_format                     = "CSV"
    max_bad_records                 = 0
    ignore_unknown_values           = false
    field_delimiter                 = "|"
    skip_leading_rows               = 1
    allow_quoted_newlines           = false
    allow_jagged_rows               = false
  }
}

# Showroom
resource "google_bigquery_data_transfer_config" "showroom_dtc" {
  project                = var.project_id
  location               = var.region
  destination_dataset_id = google_bigquery_dataset.ds_gcp_bda.dataset_id
  display_name           = "showroom-dtc"
  data_source_id         = "google_cloud_storage"

  # schedule_options {
  #   disable_auto_scheduling = true
  # }

  params = {
    destination_table_name_template = google_bigquery_table.showroom_tbl.table_id
    data_path_template              = "gs://${var.cs_datagen_bucket_name}/datasets/showroom/showroom.psv"
    write_disposition               = "APPEND"
    delete_source_files             = false
    file_format                     = "CSV"
    max_bad_records                 = 0
    ignore_unknown_values           = false
    field_delimiter                 = "|"
    skip_leading_rows               = 1
    allow_quoted_newlines           = false
    allow_jagged_rows               = false
  }
}

# Sales
resource "google_bigquery_data_transfer_config" "sales_dtc" {
  project                = var.project_id
  location               = var.region
  destination_dataset_id = google_bigquery_dataset.ds_gcp_bda.dataset_id
  display_name           = "sales-dtc"
  data_source_id         = "google_cloud_storage"

  # schedule_options {
  #   disable_auto_scheduling = true
  # }

  params = {
    destination_table_name_template = google_bigquery_table.sales_tbl.table_id
    data_path_template              = "gs://${var.cs_datagen_bucket_name}/datasets/sales/sales.psv"
    write_disposition               = "APPEND"
    delete_source_files             = false
    file_format                     = "CSV"
    max_bad_records                 = 0
    ignore_unknown_values           = false
    field_delimiter                 = "|"
    skip_leading_rows               = 1
    allow_quoted_newlines           = false
    allow_jagged_rows               = false
  }
}

# Stock
resource "google_bigquery_data_transfer_config" "stocks_dtc" {
  project                = var.project_id
  location               = var.region
  destination_dataset_id = google_bigquery_dataset.ds_gcp_bda.dataset_id
  display_name           = "stocks-dtc"
  data_source_id         = "google_cloud_storage"

  # schedule_options {
  #   disable_auto_scheduling = true
  # }

  params = {
    destination_table_name_template = google_bigquery_table.stocks_tbl.table_id
    data_path_template              = "gs://${var.cs_datagen_bucket_name}/datasets/stocks/stocks.psv"
    write_disposition               = "APPEND"
    delete_source_files             = false
    file_format                     = "CSV"
    max_bad_records                 = 0
    ignore_unknown_values           = false
    field_delimiter                 = "|"
    skip_leading_rows               = 1
    allow_quoted_newlines           = false
    allow_jagged_rows               = false
  }
}
