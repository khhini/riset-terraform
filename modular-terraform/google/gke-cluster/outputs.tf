output "cluster_name" {
  value = google_container_cluster.iaac_gke.name
}

output "cluster_endpoint" {
  value = google_container_cluster.iaac_gke.endpoint
}

output "cluster_ca_certificate" {
  value = google_container_cluster.iaac_gke.master_auth.0.cluster_ca_certificate
}