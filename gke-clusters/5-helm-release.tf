resource "helm_release" "istio_base" {
  name = "istio-base"

  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istio/base"

  namespace  = "istio-system"
}

resource "helm_release" "istiod" {
  name = "istiod"

  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istio/istiod"

  namespace  = "istio-system"
}

resource "helm_release" "istio_ingress" {
  name = "istio-ingress"

  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istio/gateway"

  namespace  = "istio-ingress"
}
