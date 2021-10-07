# Name: outputs.tf
# Owner: Saurav Mitra
# Description: Outputs the Bucket Name & URL

output "cs_datagen_bucket_name" {
  value       = local.datagen_bucket_name
  description = "The Cloud Storage Bucket Name for Generated Datasets."
}

output "cs_datagen_bucket_url" {
  value       = google_storage_bucket.datagen_bucket.url
  description = "The Cloud Storage Bucket URL for Generated Datasets."
}

output "cs_resultset_bucket_name" {
  value       = local.resultset_bucket_name
  description = "The Cloud Storage Bucket Name for Resultset Datasets."
}

output "cs_resultset_bucket_url" {
  value       = google_storage_bucket.resultset_bucket.url
  description = "The Cloud Storage Bucket URL for Resultset Datasets."
}
