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
  #service_account = "projects/${var.elastic_project}/serviceAccounts/${var.tf_sa}"

  github {
    owner = "jacksonsteiner"
    name  = "Elasticstack-on-Autopilot"
    push {
      branch = "^main$"
    }
  }

  build {
    step {
      name = "gcr.io/cloud-builders/docker"
      args = [
        "build",
        "-t",
        "us-east1-docker.pkg.dev/$PROJECT_ID/elastic-repository/apm-server:latest",
        "."
      ]
    }
    step {
      name = "gcr.io/cloud-builders/docker"
      args = [
        "push",
        "us-east1-docker.pkg.dev/$PROJECT_ID/elastic-repository/apm-server:latest"
      ]
    }
  }
}