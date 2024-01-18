
resource "kubernetes_deployment" "pgadmin" {
  metadata {
    name = "pgadmin-depl"
    labels = {
      App = "pgadmin"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "pgadmin"
      }
    }
    template {
      metadata {
        labels = {
          App = "pgadmin"
        }
      }
      spec {
        container {
          image = "dpage/pgadmin4"
          name  = "pgadmin-container"

          env {
            name = "PGADMIN_DEFAULT_EMAIL"
            value = "htemal@myges.fr"
          }
          env {
            name = "PGADMIN_DEFAULT_PASSWORD"
            value = "password"
          }
          port {
            container_port = 80
          }

        }
      }
    }
  }
}

resource "kubernetes_service" "pgadmin" {
  metadata {
    name = "pgadmin-service"
  }
  spec {
    selector = {
      App = kubernetes_deployment.pgadmin.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 8888
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
