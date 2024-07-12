resource "google_compute_network" "vpc_network" {
  name                    = var.vpc
  project                 = var.aiml_project
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet
  project       = var.aiml_project
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-east1"
  network       = google_compute_network.vpc_network.id
  secondary_ip_range {
    range_name    = var.subnet-pods
    ip_cidr_range = "192.168.10.0/24"
  }
  secondary_ip_range {
    range_name    = var.subnet-services
    ip_cidr_range = "192.168.11.0/24"
  }
}
