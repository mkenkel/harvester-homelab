terraform {
  required_version = ">= 1.0"

  required_providers {
    harvester = {
      source  = "harvester/harvester"
      version = ">= 0.6.0"
    }
  }
}

# Configure the Harvester provider
provider "harvester" {
  kubeconfig = var.harvester_kubeconfig_path
}

# Create a VM using the reusable module
module "ubuntu_vm" {
  source = "./modules/vm"

  vm_name      = var.vm_name
  vm_namespace = var.vm_namespace
  vm_cpu       = var.vm_cpu
  vm_memory    = var.vm_memory
  vm_disk_size = var.vm_disk_size
  network_name = var.network_name
  image_name   = var.image_name
  cloud_init_config = templatefile("${path.module}/cloud-init/ubuntu.yaml", {
    ssh_public_key = var.ssh_public_key
    hostname       = var.vm_name
  })

  tags = {
    environment = "homelab"
    managed_by  = "terraform"
    os          = "ubuntu"
  }
}