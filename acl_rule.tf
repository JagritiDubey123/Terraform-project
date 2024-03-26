provider "google" {
  project     = "jagriti-411012"
  credentials = file("C:/Users/JAGRITI/Downloads/jagriti-411012-f2cd08035bac.json")
}

resource "google_storage_bucket" "bucket_acl" {
  name          = "bucket-acl-terra"
  location      = "US"
  force_destroy = true
}

resource "google_storage_bucket_iam_binding" "acl_bucket_owner" {
  bucket = google_storage_bucket.bucket_acl.name

  role    = "roles/storage.objectAdmin"
  members = ["user:jagritia998@gmail.com"]
}

resource "google_storage_bucket_iam_binding" "acl_bucket_reader" {
  bucket = google_storage_bucket.bucket_acl.name

  role    = "roles/storage.objectViewer"
  members = ["user:jagritia998@gmail.com"]
}
