resource "google_compute_network" "vpc_network" {
  name                    = "mageai-network"
  auto_create_subnetworks = true
}

resource "google_compute_firewall" "zoomcamp_firewall_rules" {
  name    = "zoomcamp-allow-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

#   source_tags = ["zoomcamp"]
  source_ranges = ["0.0.0.0/0"]
}