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

module "harvester-base" {
  source = "./modules/harvester-base"
}
