
resource "kubernetes_deployment" "postgres" {
  metadata {
    name = "postgres-depl"
    labels = {
      App = "postgres"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "postgres"
      }
    }
    template {
      metadata {
        labels = {
          App = "postgres"
        }
      }
      spec {
        container {
          image = "postgres:14-alpine"
          name  = "postgres-container"
          env {
            name = "POSTGRES_USER"
            value = "esgi"
          }
          env {
            name = "POSTGRES_PASSWORD"
            value = "esgi"
          }
          env {
            name = "POSTGRES_DB"
            value = "esgi_db"
          }
          port {
            container_port = 5432
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "postgres" {
  metadata {
    name = "postgres-service"
  }
  spec {
    selector = {
      App = kubernetes_deployment.postgres.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 5432
      target_port = 5432
    }

    type = "LoadBalancer"
  }
}
