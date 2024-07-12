locals {
  cluster_ca_certificate = google_container_cluster.es-cluster.master_auth != null ? google_container_cluster.es-cluster.master_auth[0].cluster_ca_certificate : ""
  endpoint               = google_container_cluster.es-cluster.endpoint
  host                   = local.endpoint != "" ? "https://${local.endpoint}" : ""
}

resource "google_project_service" "serviceusage" {
  project = var.aiml_project
  service = "serviceusage.googleapis.com"
}

resource "google_project_service" "cloudresourcemanager" {
  project = var.aiml_project
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "cloudbilling" {
  project = var.aiml_project
  service = "cloudbilling.googleapis.com"
}

resource "google_project_service" "compute" {
  project = var.aiml_project
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  project = var.aiml_project
  service = "container.googleapis.com"
}