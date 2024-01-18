terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("service-account-key/able-tide-408712.json")

  project = "able-tide-408712"
  region  = "europe-west9"
  zone    = "europe-west9-a"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    # This means that when we create the VM instance,
    # it will use "terraform-network" instead of the default VPC network for the project.
    # If you run terraform plan, you will see that "terraform-instance" depends on "terraform-network".
    network = "default"
    access_config {
    }
  }

  metadata_startup_script = file("${path.module}/templates/script.sh")
}


variable "script" {
  default = "templates/script.sh"
}