# main.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the Cloud Storage Buckets

resource "random_integer" "rid" {
  min = 100
  max = 900
}

locals {
  suffix                = random_integer.rid.result
  datagen_bucket_name   = "gcp-bigdata-demo-datagen-${local.suffix}"
  resultset_bucket_name = "gcp-bigdata-demo-resultset-${local.suffix}"
}

resource "google_storage_bucket" "datagen_bucket" {
  project                     = var.project_id
  name                        = local.datagen_bucket_name
  location                    = var.region
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  force_destroy               = true

  labels = {
    name    = local.datagen_bucket_name
    owner   = var.owner
    project = var.prefix
  }
}

resource "google_storage_bucket" "resultset_bucket" {
  project                     = var.project_id
  name                        = local.resultset_bucket_name
  location                    = var.region
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  force_destroy               = true

  labels = {
    name    = local.resultset_bucket_name
    owner   = var.owner
    project = var.prefix
  }
}

# Upload Sample Dataset Files
resource "google_storage_bucket_object" "datafiles" {
  for_each = fileset(path.module, "**/*.psv")

  bucket = google_storage_bucket.datagen_bucket.name
  name   = each.value
  source = "${path.module}/${each.value}"

  metadata = {
    owner   = var.owner
    project = var.prefix
  }
}

# Upload Dataproc Initialization Script Files
resource "google_storage_bucket_object" "init_script_files" {
  for_each = fileset(path.module, "**/*.sh")

  bucket = google_storage_bucket.datagen_bucket.name
  name   = each.value
  source = "${path.module}/${each.value}"

  metadata = {
    owner   = var.owner
    project = var.prefix
  }
}

# Upload Hive Script Files
resource "google_storage_bucket_object" "hive_script_files" {
  for_each = fileset(path.module, "scripts/*.hql")

  bucket = google_storage_bucket.datagen_bucket.name
  name   = each.value
  source = "${path.module}/${each.value}"

  metadata = {
    owner   = var.owner
    project = var.prefix
  }
}

# Upload Pig Script Files
resource "google_storage_bucket_object" "pig_script_files" {
  for_each = fileset(path.module, "scripts/*.pig")

  bucket = google_storage_bucket.datagen_bucket.name
  name   = each.value
  source = "${path.module}/${each.value}"

  metadata = {
    owner   = var.owner
    project = var.prefix
  }
}

# Upload Python Spark Files
resource "google_storage_bucket_object" "spark_script_files" {
  for_each = fileset(path.module, "scripts/*.py")

  bucket = google_storage_bucket.datagen_bucket.name
  name   = each.value
  source = "${path.module}/${each.value}"

  metadata = {
    owner   = var.owner
    project = var.prefix
  }
}
