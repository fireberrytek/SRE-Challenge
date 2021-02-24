terraform {
  required_version = "~>0.12"
  backend "remote" {
    organization = "fireberrytek"
    workspaces {
      name = "gkecluster"
    }
  }
}

resource "google_container_cluster" "primary" {
  name               = var.cluster
  location           = var.zone
  provider           = google-beta
  
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  # Disable basic authentication
  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
  
  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }
    
  addons_config {
    istio_config {
      disabled = false
      auth     = "AUTH_NONE"
    }
  }
}
  
resource "google_container_node_pool" "primary_nodes" {
  name         = var.nodepool
  location     = var.zone
  cluster      = google_container_cluster.primary.name
  node_count   = 3
  
  node_config {
    preemptible  = var.preemptible_nodes
    machine_type = var.machine_type
    
    metadata = {
      disable-legacy-endpoints = "true"
    }
    
    labels = {
      app = var.app_name
      team = var.team_name
    }
    
    tags = ["app", var.app_name]
    
    # Google recommends custom service accounts that have cloud-platform
    # scope and permissions granted via IAM Roles.
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 3
    max_node_count = 8
  }
  
  timeouts {
    create = "30m"
    update = "40m"
  }
}
