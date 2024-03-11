resource "google_compute_network" "this" {
  name = var.network
}

resource "google_compute_subnetwork" "web" {
  name          = var.subnetwork_name
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = google_compute_network.this.id
}


resource "google_compute_address" "gcp_vpn_gateway_ip" {
  name         = var.google_compute_address_name
  region       = var.region
}


resource "google_compute_vpn_gateway" "target_gateway" {
  name    = var.google_compute_vpn_gateway_name
  region  = var.region
  network = google_compute_network.this.id
}

resource "google_compute_forwarding_rule" "fr_esp" {
  for_each = var.forwarding_rules
  name        = each.value.name
  ip_protocol = each.value.ip_protocol
  port_range = each.value.port_range
  region      = var.region
  ip_address  = google_compute_address.gcp_vpn_gateway_ip.address
  target      = google_compute_vpn_gateway.target_gateway.id
}

resource "google_compute_vpn_tunnel" "vpn_tunnel" {
  name                    = var.vpn_tunnel_name
  peer_ip                 = azurerm_public_ip.this.ip_address
  shared_secret           = var.shared_secret
  target_vpn_gateway      = google_compute_vpn_gateway.target_gateway.id
  region                  = var.region
  local_traffic_selector  = var.local_traffic_selector
  remote_traffic_selector = var.remote_traffic_selector
  peer_external_gateway   = google_compute_external_vpn_gateway.azure.self_link
}

resource "google_compute_external_vpn_gateway" "azure" {
  name            = var.redundancy_type
  redundancy_type = var.redundancy_type
  description     = "An externally managed VPN gateway"
  interface {
    id         = 0
    ip_address = azurerm_public_ip.this.ip_address
  }
}
