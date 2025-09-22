terraform {
  required_providers {
    harvester = {
      source  = "harvester/harvester"
      version = "1.6.0"
    }
  }
}

# Configure Harvester provider
provider "harvester" {
  kubeconfig = var.kubeconfig_path
}

module "networking" {
  source = "./modules/networking"
}

module "vm-images" {
  source = "./modules/vm-images"
}
