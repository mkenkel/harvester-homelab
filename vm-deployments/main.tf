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

# Optional: Deploy multiple VMs using for_each
module "ubuntu_vms" {
  source = "./modules/vm"

  for_each = var.additional_vms

  vm_name     = each.key
  namespace   = var.namespace
  description = each.value.description

  cpu_cores = each.value.cpu_cores
  memory    = each.value.memory
  disk_size = each.value.disk_size

  vm_image             = var.ubuntu_image
  network_name         = var.network_name
  storage_class        = var.storage_class
  cloud_init_user_data = local.ubuntu_cloud_init

  hostname = each.value.hostname

  tags = merge(
    {
      environment = var.environment
      project     = "harvester-homelab"
      os          = "ubuntu"
    },
    each.value.tags
  )
}