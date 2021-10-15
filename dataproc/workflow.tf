# job.tf
# Owner: Saurav Mitra
# Description: This terraform config will create a Dataproc Workflow

resource "google_dataproc_workflow_template" "bda_workflow_template" {
  project  = var.project_id
  location = google_dataproc_cluster.dataproc_gcp_bda.region
  name     = "workflow-dataproc-gcp-bda"

  placement {
    cluster_selector {
      cluster_labels = {
        name    = "dataproc-gcp-bda"
        owner   = var.owner
        project = var.prefix
      }
    }
  }

  jobs {
    step_id = "copy-data-from-gs-to-hdfs"

    labels = {
      name    = "copy-data-from-gs-to-hdfs"
      owner   = var.owner
      project = var.prefix
    }

    hadoop_job {
      main_class = "org.apache.hadoop.tools.DistCp"
      args = [
        "--",
        "gs://${var.cs_datagen_bucket_name}/datasets/",
        "hdfs:///datasets",
      ]
    }
  }

  jobs {
    step_id               = "create-load-hive-dim-tbls-create-hive-fact-tbl"
    prerequisite_step_ids = ["copy-data-from-gs-to-hdfs"]

    labels = {
      name    = "create-load-hive-dim-tbls-create-hive-fact-tbl"
      owner   = var.owner
      project = var.prefix
    }

    hive_job {
      query_file_uri = "gs://${var.cs_datagen_bucket_name}/scripts/tables.hql"
    }
  }

  jobs {
    step_id               = "pig-etl-hive-fact-tables"
    prerequisite_step_ids = ["copy-data-from-gs-to-hdfs", "create-load-hive-dim-tbls-create-hive-fact-tbl"]

    labels = {
      name    = "pig-etl-hive-fact-tables"
      owner   = var.owner
      project = var.prefix
    }

    pig_job {
      query_file_uri = "gs://${var.cs_datagen_bucket_name}/scripts/etl.pig"
    }
  }

  jobs {
    step_id               = "pyspark-create-sales-view"
    prerequisite_step_ids = ["copy-data-from-gs-to-hdfs", "create-load-hive-dim-tbls-create-hive-fact-tbl", "pig-etl-hive-fact-tables"]

    labels = {
      name    = "pyspark-create-sales-view"
      owner   = var.owner
      project = var.prefix
    }

    pyspark_job {
      main_python_file_uri = "gs://${var.cs_datagen_bucket_name}/scripts/etl.py"
    }
  }
}
