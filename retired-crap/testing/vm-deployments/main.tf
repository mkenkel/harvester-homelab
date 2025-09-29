terraform {
  required_version = ">= 1.0"
  required_providers {
    harvester = {
      source  = "harvester/harvester"
      version = ">= 0.6.0"
    }
  }
}

# Configure Harvester provider
provider "harvester" {
  kubeconfig = var.kubeconfig_path
}

# Load cloud-init configuration
locals {
  ubuntu_cloud_init = file("${path.module}/cloud-init/ubuntu.yaml")
}

# Example VM deployment using the module
module "ubuntu_vm_example" {
  source = "./modules/vm"

  vm_name     = var.vm_name
  namespace   = var.namespace
  description = "Ubuntu VM deployed with Terraform"

  cpu_cores = var.cpu_cores
  memory    = var.memory
  disk_size = var.disk_size

  vm_image             = var.ubuntu_image
  network_name         = var.network_name
  storage_class        = var.storage_class
  cloud_init_user_data = local.ubuntu_cloud_init

  hostname = var.vm_hostname

  tags = {
    environment = var.environment
    project     = "harvester-homelab"
    os          = "ubuntu"
  }
}

