resource "helm_release" "kaili-operator" {
  name = "kaili"

  repository = "https://kiali.org/helm-charts"
  chart      = "kiali-operator"

  namespace  = "kiali-operator"

  set {
    name  = "cr.create"
    value = "true"
  }

  set {
    name = "cr.namespace"
    value = "istio-system"
  }
    
}