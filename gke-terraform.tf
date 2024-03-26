provider "google" {
  project = "jagriti-411012"
   credentials = "${file("C:/Users/JAGRITI/Downloads/jagriti-411012-f2cd08035bac.json")}"
#   region  = "us-central1"
}


# Create a GKE cluster
resource "google_container_cluster" "my_cluster21" {
  name               = "my-cluster21"
  location           = "us-central1"
  remove_default_node_pool = false

  # Set deletion protection to false to allow cluster deletion
  deletion_protection = false

  # Network configuration
  network           = google_compute_network.my_network12.name
  subnetwork        = google_compute_subnetwork.my_subnet1.name

  # Addon configuration
  addons_config {
    network_policy_config {
      disabled = true
    }
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  # Node pool with private nodes
  node_pool {
    name               = "private-pool"
    initial_node_count = 1
    node_locations     = ["us-central1"]

    management {
      auto_repair  = true
      auto_upgrade = true
    }

    # Labels for node pool (optional)
    node_config {
      labels = {
        "environment" = "production"
      }
    }
  }
}

# Create a Google Compute Network
resource "google_compute_network" "my_network12" {
  name                    = "my-network12"
  auto_create_subnetworks = false
}

# Create a Google Compute Subnetwork
resource "google_compute_subnetwork" "my_subnet1" {
  name          = "my-subnet1"
  network       = google_compute_network.my_network12.self_link
  region        = "us-central1"
  ip_cidr_range = "10.0.0.0/24"
}
