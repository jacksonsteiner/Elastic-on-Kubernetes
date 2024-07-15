resource "kubernetes_namespace" "es-cluster1" {
  metadata {
    name = "es-cluster1"
  }
}

resource "kubectl_manifest" "daemonset" {
    yaml_body = <<YAML
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: max-map-count-setter
  namespace: es-cluster1
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
  depends_on = [ kubectl_manifest.daemonset ]
}
