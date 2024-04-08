provider "google" {
  project     = "jagriti-411012"
  credentials = file("C:/Users/JAGRITI/Downloads/jagriti-411012-4c9ab7bf4591.json")
}

resource "google_compute_network" "my_network12" {
  name                    = "my-network12"
  auto_create_subnetworks = false
}

# Create a Google Compute Subnetwork
resource "google_compute_subnetwork" "my_subnet1" {
  name          = "giit-subnet1"
  network       = google_compute_network.my_network12.self_link
  region        = "us-central1"
  ip_cidr_range = "10.0.0.0/24"
}

resource "google_container_cluster" "my_cluster" {
  name                     = "giit-gke-cluster"
  location                 = "us-central1-a"
  deletion_protection = false
  remove_default_node_pool = true
  initial_node_count       = 1
  #   network_policy     = "DISABLED"  # Disable network policy to allow private cluster access

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "192.168.0.100/32" # Allow access to the master from your IP range
      display_name = "My IP"
    }
  }

  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28" # Choose an appropriate range for master IP
  }

  network    = google_compute_network.my_network12.name
  subnetwork = google_compute_subnetwork.my_subnet1.name
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "giit-node-pool"
  location   = "us-central1-a"
  cluster    = google_container_cluster.my_cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    disk_size_gb = 100
    disk_type    = "pd-standard"
  }
}
