resource "google_compute_network" "network" {
  name = "${var.prefix}-network"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.prefix}-subnet"
  network       = google_compute_network.network.self_link
  ip_cidr_range = "10.0.0.0/24"
}

resource "google_compute_firewall" "allow-http" {
  name    = "${var.prefix}-allow-http"
  network = google_compute_network.network.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-https" {
  name    = "${var.prefix}-allow-https"
  network = google_compute_network.network.name
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
}