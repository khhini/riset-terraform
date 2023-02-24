resource "kubernetes_namespace" "istio-system" {
  metadata {
    name = "istio-system" 
  }
}

resource "kubernetes_namespace" "istio-ingress" {
  metadata {
    name = "istio-ingress"
  }
}

resource "kubernetes_namespace" "kiali-operator" {
  metadata {
    name = "kiali-operator" 
  }
}