resource "google_service_account" "gke_sa" {
  account_id = "gke-sa"
  display_name = "Service Account"
}

