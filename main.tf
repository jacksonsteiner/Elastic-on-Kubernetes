module "autopilot" {
  source          = "./autopilot"
  elastic_project = var.elastic_project
  tf_sa           = var.tf_sa
  region          = var.region
  vpc             = var.vpc
  subnet          = var.subnet
  subnet-pods     = var.subnet-pods
  subnet-services = var.subnet-services
  cluster         = var.cluster
}

module "deployment" {
  source     = "./deployment"
  cluster    = var.cluster
  depends_on = [ module.autopilot ]
  providers  = {
    kubectl = kubectl.kubectl
    helm    = helm.helm
  }
}