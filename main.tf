# main.tf
provider "google" {
  project =  "jagriti-411012"
  credentials = "${file("C:/Users/JAGRITI/Downloads/jagriti-411012-f2cd08035bac.json")}"
  #region  = ""
  # zone = "us-central1-a"
  #project = "terraform-project1-417611"
}
# Declare the provider (GCP)
# provider "google" {
#   project = "jagriti-411012"
#   region  = "us-central1"
# }

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

# resource "google_project" "terraform-project" {
#   name       = "terraform-project"
#   project_id = "jagriti-terraform-123"  # Specify a unique project ID for your new project
#   org_id     = null  # Set org_id to null for a standalone project
# }


# resource "google_project" "giit" {
#   name       = "terraform-giiit"
#   project_id = "terraform-giit-12345"
# }












 # machine_type = "f1-micro"
  # zone = "us-central1-a"
  # allow_stopping_for_updates = true


  # boot_disk{
  #   initialize_params{
  #     image = "debian-cloud/debian-10"
  #   }
  # }
  # network_interface {
  #   network = "default"
  #   access_config {
  #           //necessary even empty
  #   }
  # }
