variable "name" {}
variable "region" {}
variable "subnetwork_id" {}

resource "google_compute_instance" "tpot" {
  name         = var.name
  machine_type = "n2-highmem-2" # 2 vCPUs, 16 GB memory
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 128
      type  = "pd-ssd"
    }
  }

  metadata = {
    ssh-keys = format("%s:%s","ubuntu", file("${path.root}/keys/id_rsa.pub"))
  }

  network_interface {
    subnetwork = var.subnetwork_id

    access_config {
      // Ephemeral public IP
    }
  }
}

# NOTE:
# If the T-Pot installer does not select the appropriate network interface during T-Pot installation, consider editing T-Pot's docker-compose settings.
