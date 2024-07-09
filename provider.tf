terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.36.0"
    }
  }
  backend "gcs" {
    bucket                      = "es-terraform-07082024"
    impersonate_service_account = "sa-elastic@elastic-07082024.iam.gserviceaccount.com"
  }
}

provider "google" {
  project = "elasticstack"
  alias   = "impersonation"
  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

provider "google" {
 project 		     = "elasticstack-07082024"
 access_token	   = data.google_service_account_access_token.default.access_token
 request_timeout = "60s"
}

locals {
  elastic_service_account = "sa-elastic@elasticstack-07082024.iam.gserviceaccount.com"
}