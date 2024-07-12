resource "kubernetes_namespace" "es-cluster1" {
  metadata {
    name = "es-cluster1"
  }
}

resource "kubernetes_manifest" "daemonset" {
  manifest = yamldecode(file("${path.module}/daemonset.yaml"))
}

resource "helm_release" "es-cluster1" {
  name       = "es-cluster1"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "elasticsearch"
  version    = "21.2.8"
  namespace   = "es-cluster1"
  create_namespace = true

  values = [
    "${file("${path.module}/values.yaml")}"
  ]
  depends_on = [ kubernetes_manifest.daemonset ]
}

