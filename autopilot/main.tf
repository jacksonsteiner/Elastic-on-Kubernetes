locals {
  cluster_ca_certificate = google_container_cluster.es-cluster.master_auth != null ? google_container_cluster.es-cluster.master_auth[0].cluster_ca_certificate : ""
  endpoint               = google_container_cluster.es-cluster.endpoint
  host                   = local.endpoint != "" ? "https://${local.endpoint}" : ""
}

resource "google_project_service" "serviceusage" {
  project = var.elastic_project
  service = "serviceusage.googleapis.com"
}

resource "google_project_service" "cloudresourcemanager" {
  project = var.elastic_project
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "cloudbilling" {
  project = var.elastic_project
  service = "cloudbilling.googleapis.com"
}

resource "google_project_service" "compute" {
  project = var.elastic_project
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  project = var.elastic_project
  service = "container.googleapis.com"
}

resource "google_project_service" "artifactregistry" {
  project = var.elastic_project
  service = "artifactregistry.googleapis.com"
}

resource "google_project_service" "cloudbuild" {
  project = var.elastic_project
  service = "cloudbuild.googleapis.com"
}