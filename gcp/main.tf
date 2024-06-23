variable "admin_ip" {}
variable "vpc_cidr" {}
variable "subnet_cidr" {}
variable "project_id" {}

# PROVIDER
provider "google" {
  alias  = "jp"
  region = "asia-northeast1"
  project = var.project_id
}

provider "google" {
  alias  = "us"
  region = "us-east4"
  project = var.project_id
}

# ENABLE COMPUTE API
resource "google_project_service" "enable_compute" {
  project = var.project_id
  service = "compute.googleapis.com"
}

# NETWORK
module "network_jp" {
  name = "tpot-jp"
  source = "./network"
  region = "asia-northeast1"
  admin_ip =  var.admin_ip
  subnet_cidr =  var.subnet_cidr
  providers = {
    google = google.jp
  }
}

module "network_us" {
  name = "tpot-us"
  source = "./network"
  region = "us-east4"
  admin_ip =  var.admin_ip
  subnet_cidr =  var.subnet_cidr
  providers = {
    google = google.us
  }
}

# COMPUTE
module "compute_jp" {
  name = "tpot-jp"
  source = "./compute"
  region = "asia-northeast1"
  subnetwork_id = module.network_jp.subnetwork_id
  providers = {
    google = google.jp
  }
}

module "compute_us" {
  name = "tpot-us"
  source = "./compute"
  region = "us-east4"
  subnetwork_id = module.network_us.subnetwork_id
  providers = {
    google = google.us
  }
}
