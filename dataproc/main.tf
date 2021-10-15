# main.tf
# Owner: Saurav Mitra
# Description: This terraform config will create the Dataproc Resources

resource "google_dataproc_autoscaling_policy" "asp_gcp_bda" {
  project   = var.project_id
  location  = var.region
  policy_id = "asp_gcp_bda"

  worker_config {
    max_instances = 3
  }

  basic_algorithm {
    yarn_config {
      graceful_decommission_timeout = "30s"

      scale_up_factor   = 0.5
      scale_down_factor = 0.5
    }
  }
}


resource "google_dataproc_cluster" "dataproc_gcp_bda" {
  project                       = var.project_id
  region                        = var.region
  name                          = "dataproc-gcp-bda"
  graceful_decommission_timeout = "120s"

  labels = {
    name    = "dataproc-gcp-bda"
    owner   = var.owner
    project = var.prefix
  }

  cluster_config {
    staging_bucket = var.cs_resultset_bucket_name
    temp_bucket    = var.cs_resultset_bucket_name

    gce_cluster_config {
      zone = var.zone
      # network = var.vpc_name
      subnetwork = var.public_subnet_name.0
      # tags       = ["bda"]
      internal_ip_only = false

      # service_account = google_service_account.default.email
      # service_account_scopes = [
      #   "cloud-platform"
      # ]
    }

    # endpoint_config {
    #   enable_http_port_access = true
    # }

    master_config {
      machine_type  = var.master_machine_type
      num_instances = var.master_num_instances

      disk_config {
        boot_disk_type    = var.master_boot_disk_type
        boot_disk_size_gb = var.master_boot_disk_size_gb
      }
    }

    worker_config {
      machine_type  = var.worker_machine_type
      num_instances = var.worker_num_instances

      disk_config {
        boot_disk_type    = var.worker_boot_disk_type
        boot_disk_size_gb = var.worker_boot_disk_size_gb
        # num_local_ssds    = 0
      }
    }

    preemptible_worker_config {
      num_instances = 0
    }

    # Override or set some custom properties
    software_config {
      image_version       = var.dataproc_version
      optional_components = var.dataproc_optional_components

      # override_properties = {
      #   "dataproc:dataproc.allow.zero.workers" = "true"
      # }
    }

    # security_config {}

    # autoscaling_config {
    #   policy_uri = google_dataproc_autoscaling_policy.asp_gcp_bda.name
    # }

    initialization_action {
      script = "gs://${var.cs_datagen_bucket_name}/scripts/hive-hcatalog.sh"
      # timeout_sec = 500
    }

    # encryption_config {}
    # lifecycle_config {}
    # endpoint_config {}
    # metastore_config {}
  }

  # timeouts {
  #   create = "30m"
  #   delete = "1h"
  # }
}
