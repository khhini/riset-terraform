terraform {
  required_providers {
    google ={
      source = "hashicorp/google"
      version = "4.50.0"
    }
    helm = {
      source = "hashicorp/helm"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.17.0"
    }
  }
  backend "gcs" {
    bucket = "riset-terraform-tfstate-bkt"
    prefix = "terraform/gke-cluster-state"
  }
}

provider "google" {
  project = var.project
  region = var.region
  zone = var.zone 
}

data "google_client_config" "provider" {
  
}

provider "helm" {
  kubernetes{
    host  = "https://${google_container_cluster.iaac_gke.endpoint}"
    token = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(
      google_container_cluster.iaac_gke.master_auth.0.cluster_ca_certificate
    )
  }
}

provider "kubernetes" {
  host  = "https://${google_container_cluster.iaac_gke.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(
    google_container_cluster.iaac_gke.master_auth.0.cluster_ca_certificate
  )
}
