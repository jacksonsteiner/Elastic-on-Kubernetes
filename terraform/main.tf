
// resource "google_project" "elasticstack" {
//   name            = "elasticstack"
//   project_id      = var.aiml_project
//   auto_create_network = false
// }

module "autopilot" {
  source          = "./autopilot"
  aiml_project    = var.aiml_project
  vpc             = var.vpc
  subnet          = var.subnet
  subnet-pods     = var.subnet-pods
  subnet-services = var.subnet-services
}

module "deployment" {
  source     = "./deployment"
  depends_on = [ module.autopilot ]
}