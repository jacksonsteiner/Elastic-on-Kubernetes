resource "kubernetes_namespace" "es-cluster" {
  metadata {
    name = var.cluster
  }
}

resource "kubectl_manifest" "daemonset" {
    yaml_body = <<YAML
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: max-map-count-setter
  namespace: ${var.cluster}
  labels:
    k8s-app: max-map-count-setter
spec:
  selector:
    matchLabels:
      name: max-map-count-setter
  template:
    metadata:
      labels:
        name: max-map-count-setter
    spec:
      nodeSelector:
        cloud.google.com/compute-class: "Scale-Out"
      initContainers:
        - name: max-map-count-setter
          image: docker.io/bash:5.2.21
          resources:
            limits:
              cpu: 100m
              memory: 32Mi
          securityContext:
            privileged: true
            runAsUser: 0
          command: ['/usr/local/bin/bash', '-e', '-c', 'echo 262144 > /proc/sys/vm/max_map_count']
      containers:
        - name: sleep
          image: docker.io/bash:5.2.21
          command: ['sleep', 'infinity']
YAML
  depends_on = [ kubernetes_namespace.es-cluster ]
}

resource "helm_release" "es-cluster" {
  name       = var.cluster
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "elasticsearch"
  version    = "21.2.8"
  namespace  = var.cluster

  values = [
    "${file("${path.module}/values.yaml")}"
  ]
  depends_on = [ kubectl_manifest.daemonset ]
}
