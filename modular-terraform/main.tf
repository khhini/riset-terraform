terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.50.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.9.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.18.0"
    }
  }
  backend "gcs" {
    bucket = "riset-terraform-tfstate-bkt"
    prefix = "terraform/modular-terraform"
  }
}

provider "google" {
  project = var.project
  region = var.region
  zone = var.zone 
}

module "google_apis" {
  source = "./google/apis"
}

module "google_sa" {
  source = "./google/service-accounts"
  
}

module "google_gke_cluster" {
  source = "./google/gke-cluster"

  service_account = module.google_sa.gke_sa_email

  region = var.region
}

module "google_gke_nodes" {
  source = "./google/gke-nodes"

  service_account = module.google_sa.gke_sa_email

  gke_cluster_name = module.google_gke_cluster.cluster_name

  region = var.region
}

data "google_client_config" "google_config" {
  
}

provider "helm" {
  kubernetes {
    host = "https://${module.google_gke_cluster.cluster_endpoint}"
    token = data.google_client_config.google_config.access_token
    cluster_ca_certificate = base64decode(
      module.google_gke_cluster.cluster_ca_certificate
    )
  }
}

module "helm_istio" {
  source = "./helm/istio"
}

module "helm_kaili" {
  source = "./helm/kaili"
}

provider "kubernetes" {
  host = "https://${module.google_gke_cluster.cluster_endpoint}"
  token = data.google_client_config.google_config.access_token
  cluster_ca_certificate = base64decode(
    module.google_gke_cluster.cluster_ca_certificate
  )
}

module "kubernetes_namespaces" {
  source = "./kubernetes/namespaces"
  
}
