# main.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the Big Query Tables

# Customer
resource "google_bigquery_table" "customer_tbl" {
  project = var.project_id
  #  location            = var.region
  dataset_id          = google_bigquery_dataset.ds_gcp_bda.dataset_id
  table_id            = "customer"
  friendly_name       = "customer"
  description         = "customer table for big data analytics"
  expiration_time     = 0
  deletion_protection = false
  clustering          = ["country", "state", "gender"]

  schema = <<EOF
[
  {
    "name": "id",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "first_name",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "last_name",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "gender",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "dob",
    "type": "DATE",
    "mode": "NULLABLE"
  },
  {
    "name": "company",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "job",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "email",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "country",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "state",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "address",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "update_date",
    "type": "TIMESTAMP",
    "mode": "NULLABLE"
  },
  {
    "name": "create_date",
    "type": "TIMESTAMP",
    "mode": "NULLABLE"
  }
]
EOF

  labels = {
    owner   = var.owner
    project = var.prefix
  }
}

# Product
resource "google_bigquery_table" "product_tbl" {
  project = var.project_id
  #  location            = var.region
  dataset_id          = google_bigquery_dataset.ds_gcp_bda.dataset_id
  table_id            = "product"
  friendly_name       = "product"
  description         = "product table for big data analytics"
  expiration_time     = 0
  deletion_protection = false
  clustering          = ["category", "make", "color"]

  schema = <<EOF
[
  {
    "name": "id",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "code",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "category",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "make",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "model",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "year",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "color",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "price",
    "type": "NUMERIC",
    "mode": "REQUIRED"
  },
  {
    "name": "currency",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "update_date",
    "type": "TIMESTAMP",
    "mode": "NULLABLE"
  },
  {
    "name": "create_date",
    "type": "TIMESTAMP",
    "mode": "NULLABLE"
  }
]
EOF

  labels = {
    owner   = var.owner
    project = var.prefix
  }
}

# Showroom
resource "google_bigquery_table" "showroom_tbl" {
  project = var.project_id
  #  location            = var.region
  dataset_id          = google_bigquery_dataset.ds_gcp_bda.dataset_id
  table_id            = "showroom"
  friendly_name       = "showroom"
  description         = "showroom table for big data analytics"
  expiration_time     = 0
  deletion_protection = false
  clustering          = ["country", "state"]

  schema = <<EOF
[
  {
    "name": "id",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "code",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "name",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "operation_date",
    "type": "DATE",
    "mode": "REQUIRED"
  },
  {
    "name": "staff_count",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "country",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "state",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "address",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "update_date",
    "type": "TIMESTAMP",
    "mode": "NULLABLE"
  },
  {
    "name": "create_date",
    "type": "TIMESTAMP",
    "mode": "NULLABLE"
  }
]
EOF

  labels = {
    owner   = var.owner
    project = var.prefix
  }
}

# Sales
resource "google_bigquery_table" "sales_tbl" {
  project = var.project_id
  #  location            = var.region
  dataset_id          = google_bigquery_dataset.ds_gcp_bda.dataset_id
  table_id            = "sales"
  friendly_name       = "sales"
  description         = "sales table for big data analytics"
  expiration_time     = 0
  deletion_protection = false

  time_partitioning {
    type  = "MONTH"
    field = "txn_date"
  }

  clustering = ["txn_date", "product_id", "showroom_id", "customer_id"]

  schema = <<EOF
[
  {
    "name": "id",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "order_number",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "customer_id",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "showroom_id",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "product_id",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "quantity",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "discount",
    "type": "NUMERIC",
    "mode": "NULLABLE"
  },
  {
    "name": "amount",
    "type": "NUMERIC",
    "mode": "NULLABLE"
  },
  {
    "name": "delivered",
    "type": "INTEGER",
    "mode": "NULLABLE"
  },
  {
    "name": "card_type",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "card_number",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "txn_date",
    "type": "DATE",
    "mode": "NULLABLE"
  },
  {
    "name": "update_date",
    "type": "TIMESTAMP",
    "mode": "NULLABLE"
  },
  {
    "name": "create_date",
    "type": "TIMESTAMP",
    "mode": "NULLABLE"
  }
]
EOF

  labels = {
    owner   = var.owner
    project = var.prefix
  }
}

# Stocks
resource "google_bigquery_table" "stocks_tbl" {
  project = var.project_id
  #  location            = var.region
  dataset_id          = google_bigquery_dataset.ds_gcp_bda.dataset_id
  table_id            = "stocks"
  friendly_name       = "stocks"
  description         = "stocks table for big data analytics"
  expiration_time     = 0
  deletion_protection = false

  time_partitioning {
    type  = "DAY"
    field = "stock_date"
  }

  clustering = ["stock_date", "showroom_id", "product_id"]

  schema = <<EOF
[
  {
    "name": "id",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "showroom_id",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "product_id",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "quantity",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "stock_date",
    "type": "DATE",
    "mode": "REQUIRED"
  },
  {
    "name": "update_date",
    "type": "TIMESTAMP",
    "mode": "NULLABLE"
  },
  {
    "name": "create_date",
    "type": "TIMESTAMP",
    "mode": "NULLABLE"
  }
]
EOF

  labels = {
    owner   = var.owner
    project = var.prefix
  }
}
