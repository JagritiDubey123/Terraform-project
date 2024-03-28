# Provider configuration
provider "google" {
  project     = "jagriti-411012"
  credentials = file("C:/Users/JAGRITI/Downloads/jagriti-411012-f2cd08035bac.json")
}

# Create VPC network
resource "google_compute_network" "my_network1" {
  name = "my-vpc-loadbalancer"
}

# Create subnets
resource "google_compute_subnetwork" "private_subnet" {
  name                    = "private-subnet"
  region                  = "us-central1"
  network                 = google_compute_network.my_network1.self_link
  ip_cidr_range           = "10.0.1.0/24"
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "public_subnet" {
  name          = "public-subnet"
  region        = "us-central1"
  network       = google_compute_network.my_network1.self_link
  ip_cidr_range = "10.0.2.0/24"
}

# Create firewall rules
resource "google_compute_firewall" "allow_http1" {
  name    = "terraform-loadbalancer"
  network = google_compute_network.my_network1.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# Create VM instances with startup script to install Nginx
resource "google_compute_instance" "private_vm" {
  count        = 2
  name         = "private-vm-${count.index}"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network    = google_compute_network.my_network1.self_link
    subnetwork = google_compute_subnetwork.private_subnet.self_link
  }
# tags = [google_compute_firewall.allow_http1.name]
  metadata_startup_script = file("script.sh")
}

resource "google_compute_instance" "public_vm" {
  count        = 2
  name         = "public-vm-${count.index}"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network    = google_compute_network.my_network1.self_link
    subnetwork = google_compute_subnetwork.public_subnet.self_link
    access_config {}
  }
  # tags = [google_compute_firewall.allow_http1.name]

  metadata_startup_script = file("script.sh")
}

# Create target pool
resource "google_compute_target_pool" "my_target_pool" {
  name             = "my-target-pool"
  region           = "us-central1"
  health_checks    = [google_compute_http_health_check.default.self_link]
  session_affinity = "NONE"

  instances = [
    google_compute_instance.private_vm.*.self_link[0],
    google_compute_instance.private_vm.*.self_link[1],
    google_compute_instance.public_vm.*.self_link[0],
    google_compute_instance.public_vm.*.self_link[1],
  ]
}

# Create health check
resource "google_compute_http_health_check" "default" {
  name               = "default-http-check"
  request_path       = "/"
  port               = 80
  check_interval_sec = 1
  timeout_sec        = 1
}

# Create forwarding rule
resource "google_compute_forwarding_rule" "my_forwarding_rule" {
  name       = "my-forwarding-rule"
  region     = "us-central1"
  target     = google_compute_target_pool.my_target_pool.self_link
  port_range = "80"
}

# Output the IP address of the load balancer
output "load_balancer_ip" {
  value = google_compute_forwarding_rule.my_forwarding_rule.ip_address
}
