resource "google_container_cluster" "iaac_gke" {
  name = "iaac-gke"
  location = var.region
  initial_node_count = 1
  remove_default_node_pool = true


  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "cpu"
      maximum = 6
      minimum = 0
    }
    resource_limits {
      resource_type = "memory"
      minimum = 6
      maximum = 12
    }
    auto_provisioning_defaults {
      service_account = var.service_account
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
      ]
    }
  }

  # node_config {
  #   service_account = var.service_account
  #   oauth_scopes = [
  #     "https://www.googleapis.com/auth/cloud-platform"
  #   ]
  #   preemptible = true
  # }
}