resource "google_container_cluster" "iaac_gke" {
  name = "iaac-gke"
  location = var.region

  remove_default_node_pool = true
  initial_node_count  = 1

  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "cpu"
      maximum = 6
      minimum = 0
    }
    resource_limits {
      resource_type = "memory"
      minimum = 0
      maximum = 12
    }

    auto_provisioning_defaults {
      service_account = google_service_account.gke_sa.email
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
      ]
    }
  }
}