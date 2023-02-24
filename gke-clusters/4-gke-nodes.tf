resource "google_container_node_pool" "iaac_preemptible_nodes" {
  name = "iaac-preemtible-nodes"
  location = var.region
  cluster = google_container_cluster.iaac_gke.name
  node_count = 1

  node_config {
    preemptible = true
    machine_type = "e2-standard-2"
    service_account = google_service_account.gke_sa.email
    oauth_scopes =  [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  autoscaling {
    min_node_count = 0
    max_node_count = 9
    location_policy = "ANY"
  }
}
