# provider "google" {
#   project =  "jagriti-411012"
#   credentials = "${file("C:/Users/JAGRITI/Downloads/jagriti-411012-f2cd08035bac.json")}"
#   #region  = ""
#   # zone = "us-central1-a"
#   #project = "terraform-project1-417611"
# }

# resource "google_storage_bucket" "my_bucket" {
#   name          = "my-bucket-terra"
#   location      = "US"
#   force_destroy = true

#   uniform_bucket_level_access = true

#   labels = {
#     environment = "dev"
#   }
# }

# resource "google_storage_bucket_object" "my_image" {
#   name   = "my-folder/my_image.jpg"
#   bucket = google_storage_bucket.my_bucket.name
#   source = "C:/Users/JAGRITI/Documents/terraform/bg-1.jpg"
#   acl    = "publicRead"
# }
provider "google" {
project =  "jagriti-411012"
  credentials = "${file("C:/Users/JAGRITI/Downloads/jagriti-411012-f2cd08035bac.json")}"
  #region  = ""
  # zone = "us-central1-a"
  #project = "terraform-project1-417611"
}

resource "google_storage_bucket" "my_bucket-terra" {
  name          = "terraform-bucket21"
  location      = "US"
  force_destroy = true

  uniform_bucket_level_access = true

  labels = {
    environment = "dev"
  }
#    predefined_acl = "publicRead"  

}

resource "google_storage_bucket_object" "my_image" {
  name   = "my-folder/my_image.jpg"
  bucket = google_storage_bucket.my_bucket-terra.name
  source = "C:/Users/JAGRITI/Documents/terraform/bg-1.jpg"
}

# resource "google_storage_bucket_acl" "my_bucket_acl" {
#   bucket = google_storage_bucket.my_bucket.name

#   role   = "READER"
#   entity = "allUsers"
# }
