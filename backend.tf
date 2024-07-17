terraform {
  backend "gcs" {
    bucket  = "es-terraform-07082024"
    prefix  = "terraform/state"
  }
}