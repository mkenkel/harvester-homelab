terraform {
  required_version = ">= 1.0"
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

module "vm-images" {}
  source = "./modules/vm-images"
}
