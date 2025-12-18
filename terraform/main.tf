provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google" {
  alias   = "beta"
  project = var.project_id
  region  = var.region
}

resource "google_artifact_registry_repository" "frontend_repo" {
  location      = "us-central1"
  repository_id = "ob-dev-docker"
  format        = "DOCKER"

  description = "Docker images for Online Boutique frontend"
}


module "network" {
  source      = "./modules/network"
  vpc_name    = "${var.name_prefix}-${var.env}-vpc"
  subnet_name = "${var.name_prefix}-${var.env}-subnet"
  region      = var.region
}

module "gke" {
  source = "./modules/gke"

  providers = {
    google = google.beta
  }

  project_id   = var.project_id
  region       = var.region
  zone         = var.zone
  env          = var.env
  cluster_name = "${var.name_prefix}-${var.env}-gke"
  name_prefix  = var.name_prefix

  vpc_id     = module.network.vpc_id
  subnet_id  = module.network.subnet_id
  admin_cidr = var.admin_cidr
}
