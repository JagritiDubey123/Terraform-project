provider "google" {
  project      = "jagriti-411012"
  credentials  = file("C:/Users/JAGRITI/Downloads/jagriti-411012-f2cd08035bac.json")
#   region       = "us-central1"  
}

resource "google_storage_bucket" "static_bucket" {
  name          = "static-website-bucket-jagriti"
  location      = "US"
  force_destroy = true
  uniform_bucket_level_access = true

  labels = {
    environment = "dev"
  }

  website {
    main_page_suffix = "index.html"
    # not_found_page   = "404.html"
  }
}
resource "google_storage_bucket_iam_binding" "acl_bucket_reader" {
  bucket = google_storage_bucket.static_bucket.name

  role = "roles/storage.objectViewer"
 members = ["allUsers"]
}

resource "google_storage_bucket_object" "index" {
  name   = "index.html"
  bucket = google_storage_bucket.static_bucket.name
  content = <<-EOT
    <!DOCTYPE html>
    <html>
      <head>
        <title>My Static Website</title>
      </head>
      <body>
        <h1>Welcome to my static website hosted on GCS!</h1>
      </body>
    </html>
  EOT

}

# resource "google_storage_bucket_object" "not_found" {
#   name   = "404.html"
#   bucket = google_storage_bucket.static_bucket.name
#   content = "<h1>404 - Not Found</h1>"
# }
output "website_url" {
  value = "http://storage.googleapis.com/${google_storage_bucket.static_bucket.name}/index.html"
}
