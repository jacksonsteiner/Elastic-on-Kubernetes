variable "aiml_project" {
  default = "elasticstack-07082024"
}

variable "aiml_sa" {
  # change
  default = "sa-elastic@elasticstack-07082024.iam.gserviceaccount.com"
}

variable "vpc" {
  default = "net-elastic"
}

variable "subnet" {
  default = "sn-elastic"
}

variable "subnet-pods" {
  default = "sn-elastic-pods"
}

variable "subnet-services" {
  default = "sn-elastic-services"
}