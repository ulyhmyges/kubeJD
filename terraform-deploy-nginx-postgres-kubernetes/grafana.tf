/*
resource "kubernetes_namespace" "grafana" {
  metadata {
    name = "grafana"
  }
}
*/

resource "kubernetes_deployment" "grafana" {
  metadata {
    name = "grafana"
    //namespace = kubernetes_namespace.grafana.metadata[0].name
  }

  spec {
    selector {
      match_labels = {
        app = "grafana"
      }
    }

    template {
      metadata {
        labels = {
          app = "grafana"
        }
      }

      spec {
        container {
          image = "grafana/grafana:latest"
          name = "grafana"

          port {
            container_port = 3000
          }
        }
      }
    }

    replicas = 1
  }
}

resource "kubernetes_service" "grafana" {
  metadata {
    name = "grafana"
    //namespace = kubernetes_namespace.grafana.metadata[0].name
  }

  spec {
    selector = {
      app = "grafana"
    }

    port {
      name = "http"
      port = 3000
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}