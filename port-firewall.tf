provider "google" {
  project     = "jagriti-411012"
  credentials = file("C:/Users/JAGRITI/Downloads/jagriti-411012-f2cd08035bac.json")
}
resource "google_compute_firewall" "allow_ports" {
  name    = "terra-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["88", "443", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# Define the VM instance
resource "google_compute_instance" "vm_giit" {
  name         = "terraform-project"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
   tags = [google_compute_firewall.allow_ports.name]
}
