terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.37.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.31.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.14.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

provider "google" {
  alias   = "impersonation"
  scopes  = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

provider "google" {
 access_token	   = data.google_service_account_access_token.default.access_token
 request_timeout = "60s"
}

provider "kubernetes" {
  host                   = module.autopilot.host
  cluster_ca_certificate = module.autopilot.cluster_ca_certificate
  token                  = data.google_service_account_access_token.default.access_token
}

provider "kubectl" {
  alias                  = "kubectl"
  host                   = module.autopilot.host
  cluster_ca_certificate = module.autopilot.cluster_ca_certificate
  token                  = data.google_service_account_access_token.default.access_token
  load_config_file       = false
}

provider "helm" {
  alias = "helm"
  kubernetes {
    host                   = module.autopilot.host
    token                  = data.google_service_account_access_token.default.access_token
    cluster_ca_certificate = module.autopilot.cluster_ca_certificate
  }
}