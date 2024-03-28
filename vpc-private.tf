provider "google" {
  project     = "jagriti-411012"
  credentials = file("C:/Users/JAGRITI/Downloads/jagriti-411012-f2cd08035bac.json")
}
resource "google_compute_network" "my_network" {
  name                    = "my-vpc-terraform"
  auto_create_subnetworks = false
}

# Create private subnets
resource "google_compute_subnetwork" "private_subnet1" {
  name          = "private-subnet1"
  region        = "us-central1"
  network       = google_compute_network.my_network.self_link
  ip_cidr_range = "10.0.1.0/24"
    private_ip_google_access = true
}

resource "google_compute_subnetwork" "private_subnet2" {
  name          = "private-subnet2"
  region        = "us-central1"
  network       = google_compute_network.my_network.self_link
  ip_cidr_range = "10.0.2.0/24"
    private_ip_google_access = true
}

# Create public subnets
resource "google_compute_subnetwork" "public_subnet1" {
  name          = "public-subnet1"
  region        = "us-central1"
  network       = google_compute_network.my_network.self_link
  ip_cidr_range = "10.0.3.0/24"
}

resource "google_compute_subnetwork" "public_subnet2" {
  name          = "public-subnet2"
  region        = "us-central1"
  network       = google_compute_network.my_network.self_link
  ip_cidr_range = "10.0.4.0/24"
}

# Create VM instances
resource "google_compute_instance" "private_vm3" {
  name         = "private-vm3"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    network = google_compute_network.my_network.self_link
    subnetwork = google_compute_subnetwork.private_subnet1.self_link
  }
}

resource "google_compute_instance" "private_vm2" {
  name         = "private-vm2"
  machine_type = "n1-standard-1"
  zone         = "us-central1-b"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    network = google_compute_network.my_network.self_link
    subnetwork = google_compute_subnetwork.private_subnet2.self_link
  }
}

resource "google_compute_instance" "public_vm3" {
  name         = "public-vm3"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    network = google_compute_network.my_network.self_link
    subnetwork = google_compute_subnetwork.public_subnet1.self_link
    access_config {}
  }
}

resource "google_compute_instance" "public_vm2" {
  name         = "public-vm2"
  machine_type = "n1-standard-1"
  zone         = "us-central1-b"
  network_interface {
    network = google_compute_network.my_network.self_link
    subnetwork = google_compute_subnetwork.public_subnet2.self_link
    access_config {}
  }
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
}

