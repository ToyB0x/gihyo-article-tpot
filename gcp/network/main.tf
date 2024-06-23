variable "name" {}
variable "region" {}
variable "subnet_cidr" {}
variable "admin_ip" {}

# Network
resource "google_compute_network" "tpot" {
  name                    = var.name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "tpot" {
  name = var.name
  region  = var.region
  ip_cidr_range = var.subnet_cidr
  network = google_compute_network.tpot.id
}

resource "google_compute_firewall" "tpot_admin" {
  name        = "${var.name}-admin"
  network     = google_compute_network.tpot.id

  allow {
    protocol = "tcp"
    ports = [
      "64294",
      "64295",
      "64297"
    ]
  }

  priority = 100
  source_ranges = [var.admin_ip]
}

resource "google_compute_firewall" "tpot_deny" {
  name        ="${var.name}-deny"
  network     = google_compute_network.tpot.id

  deny {
    protocol = "tcp"
    ports = [
      "64294",
      "64295",
      "64297"
    ]
  }

  priority = 101
  source_ranges           = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "tpot_allow" {
  name        ="${var.name}-allow"
  network     = google_compute_network.tpot.id

  allow {
    protocol = "all"
  }
  priority = 102
  source_ranges           = ["0.0.0.0/0"]
}
