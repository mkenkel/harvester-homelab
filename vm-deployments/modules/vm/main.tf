terraform {
  required_providers {
    harvester = {
      source  = "harvester/harvester"
      version = ">= 0.6.0"
    }
  }
}

# Data source to get the VM image
data "harvester_image" "vm_image" {
  name      = split("/", var.image_name)[1]
  namespace = split("/", var.image_name)[0]
}

# Data source to get the network
data "harvester_network" "vm_network" {
  name      = split("/", var.network_name)[1]
  namespace = split("/", var.network_name)[0]
}

# Create the virtual machine
resource "harvester_virtualmachine" "vm" {
  name      = var.vm_name
  namespace = var.vm_namespace

  description = "VM created by Terraform - ${var.vm_name}"

  tags = var.tags

  cpu    = var.vm_cpu
  memory = var.vm_memory

  run_strategy    = "RerunOnFailure"
  hostname        = var.vm_name
  reserved_memory = "100Mi"
  machine_type    = "q35"

  network_interface {
    name           = "default"
    network_name   = data.harvester_network.vm_network.id
    wait_for_lease = true
  }

  disk {
    name       = "rootdisk"
    type       = "disk"
    size       = var.vm_disk_size
    bus        = "virtio"
    boot_order = 1

    image       = data.harvester_image.vm_image.id
    auto_delete = true
  }

  cloudinit {
    user_data    = var.cloud_init_config
    network_data = ""
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to these computed values to prevent unnecessary updates
      network_interface[0].mac_address,
    ]
  }
}