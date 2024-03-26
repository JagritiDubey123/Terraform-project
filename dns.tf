provider "google" {
  project     = "jagriti-411012"
  credentials = file("C:/Users/JAGRITI/Downloads/jagriti-411012-f2cd08035bac.json")
}

resource "google_dns_managed_zone" "zone-1" {
  name        = "terraform-dns"
  dns_name    = "terraform.com."
  description = "DNS zone for terraform.com"
}

resource "google_dns_record_set" "dns-record" {
  name         = "www.terraform.com."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.zone-1.name

  rrdatas = [
    "127.0.0.1"  
  ]
}

# resource "google_dns_record_set" "record-1" {
#   name         = "blog.terraform.com."
#   type         = "CNAME"
#   ttl          = 300
#   managed_zone = google_dns_managed_zone.zone-1.name

#   rrdatas = [
#     "www.terraform.com."  
#   ]
# }
