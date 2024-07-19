resource "google_artifact_registry_repository" "repository" {
  project       = var.elastic_project
  location      = var.region
  repository_id = "elastic-repository"
  format        = "DOCKER"
}

resource "google_cloudbuild_trigger" "push-trigger" {
  project         = var.elastic_project
  name            = "push-trigger"
  location        = var.region
  service_account = "projects/${var.elastic_project}/serviceAccounts/${var.tf_sa}"

  github {
    owner = "jacksonsteiner"
    name  = "Elasticstack-on-Autopilot"
    push {
      branch = "^main$"
    }
  }
  filename = "${file("${path.module}/cloudbuild.yaml")}"
}