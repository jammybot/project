resource "google_compute_network" "network" {
  name = "dvwa-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet_1" {
  name          = "subnet-1"
  ip_cidr_range = "10.1.0.0/16"
  network       = google_compute_network.network.id
}

resource "google_compute_subnetwork" "subnet_2" {
  name          = "subnet-2"
  ip_cidr_range = "10.2.0.0/16"
  network       = google_compute_network.network.id
}

resource "google_compute_firewall" "instance-firewall" {
  name = "instance-firewall"
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.network.id
  priority      = 1000
  source_ranges = ["92.237.154.94/32"]
  target_tags   = ["instance-firewall"]
}
resource "google_compute_firewall" "default" {
  name          = "fw-allow-health-check"
  direction     = "INGRESS"
  network       = google_compute_network.network.id
  priority      = 1000
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = ["allow-health-check"]
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }
}

resource "google_compute_firewall" "allow-http-from-lb" {
  name       = "allow-http-from-lb"
  direction  = "INGRESS"
  network    = google_compute_network.network.id
  priority   = 1000
  source_ranges = ["${google_compute_global_address.default.address}/32","92.237.154.94/32", "0.0.0.0/0"]
  target_tags   = ["instance-firewall"]
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}

resource "google_compute_global_address" "default" {
  name       = "lb-ipv4-1"
  ip_version = "IPV4"
}