resource "google_container_cluster" "es-cluster" {
  name     = "es-cluster"
  location = "us-east1"
  project  = var.aiml_project

  network    = var.vpc
  subnetwork = var.subnet

  ip_allocation_policy {
    cluster_secondary_range_name  = var.subnet-pods
    services_secondary_range_name = var.subnet-services
  }

  private_cluster_config {
    enable_private_nodes = true
  }
  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS","DAEMONSET","DEPLOYMENT","POD","STATEFULSET","STORAGE"]
  }
  release_channel {
    channel = "STABLE"
  }

  addons_config {
    gke_backup_agent_config {
      enabled = true
    }
  }

  enable_autopilot = true
}