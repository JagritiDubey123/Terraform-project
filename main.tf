provider "google" {
  project =  "jagriti-411012"
  credentials = "${file("C:/Users/JAGRITI/Downloads/jagriti-411012-f2cd08035bac.json")}"
 
}


# Define the VM instance
resource "google_compute_instance" "vm_instance" {
  name         = "my-vm-terra"
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
}












