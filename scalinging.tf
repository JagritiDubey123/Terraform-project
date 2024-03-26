provider "google" {
  project     = "jagriti-411012"
  credentials = file("C:/Users/JAGRITI/Downloads/jagriti-411012-f2cd08035bac.json")
}

resource "google_compute_instance_template" "template-terra" {
  name          = "terraform-template"
  machine_type  = "n1-standard-1"

  disk {
    source_image = "debian-cloud/debian-10"
    auto_delete  = true
  }

  network_interface {
    network = "default"
  }
}

resource "google_compute_instance_group_manager" "group_manager" {
  name               = "group-manager"
  base_instance_name = "instance-base"
  target_size        = 2  
  zone               = "us-central1-a" 

  version {
    name              = "v1"
    instance_template = google_compute_instance_template.template-terra.self_link
  }
}

