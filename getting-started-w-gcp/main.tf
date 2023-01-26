terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.50.0"
    }
  }
  backend "gcs" {
   bucket  = "riset-terraform-tfstate-bucket"
   prefix  = "terraform/state"
 }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "default_bucket" {
  name = "riset-terraform-tfstate-bucket"
  force_destroy = false
  location = "ASIA-SOUTHEAST1"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
  
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  tags         = ["web", "dev"]

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {

    }
  }
}
