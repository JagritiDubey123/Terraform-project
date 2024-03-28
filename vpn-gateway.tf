provider "google" {
  project      = "jagriti-411012"
  credentials  = file("C:/Users/JAGRITI/Downloads/jagriti-411012-f2cd08035bac.json")
#   region       = "us-central1"  
}

resource "google_compute_vpn_gateway" "vpn_gateway" {
  name        = "my-vpn-gateway"
  network     = "ip-instance-vm"  
  region      = "us-central1"
  description = "VPN gateway for secure communication"
}
#   resource "google_compute_forwarding_rule" "forwarding_rule" {
#   name       = "vpn-gateway-forwarding-rule"
#   region     = "us-central1"
#   target     = google_compute_vpn_gateway.vpn_gateway.self_link
#   ip_protocol     = "ESP" 
# #   port_range = "500-500"  # Example port range for IKE and ESP protocols

#   ip_address = "34.49.57.91"  # Specify another external IP address for the VPN gateway
# }

