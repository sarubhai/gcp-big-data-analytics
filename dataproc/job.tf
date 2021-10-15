# job.tf
# Owner: Saurav Mitra
# Description: This terraform config will create Dataproc Jobs

/*
resource "google_dataproc_job" "copy_data_from_GS_to_HDFS" {
  project = var.project_id
  region  = google_dataproc_cluster.dataproc_gcp_bda.region
  # force_delete = true

  placement {
    cluster_name = google_dataproc_cluster.dataproc_gcp_bda.name
  }

  labels = {
    name    = "copy-data-from-gs-to-hdfs"
    owner   = var.owner
    project = var.prefix
  }

  hadoop_config {
    main_class = "org.apache.hadoop.tools.DistCp"
    args = [
      "--",
      "gs://${var.cs_datagen_bucket_name}/datasets/",
      "hdfs:///datasets",
    ]
  }
}


resource "google_dataproc_job" "create_load_Hive_Dim_Tables_create_Hive_Fact_Tables" {
  project = var.project_id
  region  = google_dataproc_cluster.dataproc_gcp_bda.region
  # force_delete = true

  placement {
    cluster_name = google_dataproc_cluster.dataproc_gcp_bda.name
  }

  labels = {
    name    = "create-load-hive-dim-tables_create-hive-fact-tables"
    owner   = var.owner
    project = var.prefix
  }

  hive_config {
    query_file_uri = "gs://${var.cs_datagen_bucket_name}/scripts/tables.hql"
  }
}


resource "google_dataproc_job" "Pig_ETL_Hive_Fact_Tables" {
  project = var.project_id
  region  = google_dataproc_cluster.dataproc_gcp_bda.region
  # force_delete = true

  placement {
    cluster_name = google_dataproc_cluster.dataproc_gcp_bda.name
  }

  labels = {
    name    = "pig-etl-hive-fact-tables"
    owner   = var.owner
    project = var.prefix
  }

  pig_config {
    query_file_uri = "gs://${var.cs_datagen_bucket_name}/scripts/etl.pig"
  }
}


resource "google_dataproc_job" "PySpark_create_Sales_View" {
  project = var.project_id
  region  = google_dataproc_cluster.dataproc_gcp_bda.region
  # force_delete = true

  placement {
    cluster_name = google_dataproc_cluster.dataproc_gcp_bda.name
  }

  labels = {
    name    = "pyspark-create-sales-view"
    owner   = var.owner
    project = var.prefix
  }

  pyspark_config {
    main_python_file_uri = "gs://${var.cs_datagen_bucket_name}/scripts/etl.py"
  }
}

*/
