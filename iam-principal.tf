provider "google" {
  project     = "jagriti-411012"
  credentials = file("C:/Users/JAGRITI/Downloads/jagriti-411012-f2cd08035bac.json")
}

resource "google_storage_bucket" "iam-bucket" {
  name     = "bucket_iam123"
  location = "us-central1"
}

resource "google_storage_bucket_iam_binding" "bucket_binding" {
  bucket = google_storage_bucket.iam-bucket.name
  role   = "roles/storage.objectViewer" 
  members = [
    "user:jagritia998@gmail.com" 
  ]
}
