resource "google_compute_firewall" "allow_ports" {
  name    = "ter-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["88", "443", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

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
