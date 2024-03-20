# Declare the provider (GCP)
# provider "google" {
#   project =  "jagriti-411012"
#   credentials = "${file("C:/Users/JAGRITI/Downloads/jagriti-411012-0efe7430eaf6.json")}"
#   region  = "us-central1"
#   # zone = "us-central1-a"
#   #project = "terraform-project1-417611"
# }
# provider "google" {
#   project     = "jagriti-411012"
#   credentials = jsondecode(file("C:/Users/JAGRITI/Downloads/jagriti-411012-0efe7430eaf6.json"))
#   region      = "us-central1"
# }

# Define the firewall rule to allow traffic on ports 88, 443, and 22
resource "google_compute_firewall" "allow_ports" {
  name    = "ter-firewall"
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
    # target_tags = ["s1"]
  }
}
