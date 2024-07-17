variable "elastic_project" {
  default = "elasticstack-07082024"
}

variable "tf_sa" {
  default = "sa-elastic@elasticstack-07082024.iam.gserviceaccount.com"
}

variable "region" {
  default = "us-east1"
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

variable "cluster" {
  default = "es-cluster"
}