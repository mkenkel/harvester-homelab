terraform {
  required_providers {
    harvester = {
      source  = "harvester/harvester"
      version = ">= 0.6.0"
    }
  }
}

# Create virtual machine
resource "harvester_virtualmachine" "vm" {
  name                 = var.vm_name
  namespace            = var.namespace
  description          = var.description
  tags                 = var.tags
  restart_after_update = var.restart_after_update

  cpu    = var.cpu_cores
  memory = var.memory

  efi         = var.efi
  secure_boot = var.secure_boot

  run_strategy    = var.run_strategy
  hostname        = var.hostname
  reserved_memory = var.reserved_memory
  machine_type    = var.machine_type

  # Network interface
  network_interface {
    name           = "default"
    network_name   = var.network_name
    wait_for_lease = var.wait_for_lease
  }

  # Disk configuration
  disk {
    name               = "rootdisk"
    type               = "disk"
    size               = var.disk_size
    bus                = "virtio"
    boot_order         = 1
    image              = var.vm_image
    auto_delete        = true
    hot_plug           = false
    access_mode        = "ReadWriteOnce"
    volume_mode        = "Block"
    storage_class_name = var.storage_class
  }

  # Cloud-init configuration
  cloudinit {
    user_data_secret_name = harvester_cloudinit_secret.cloud_config.name
  }
}

# Cloud-init secret
resource "harvester_cloudinit_secret" "cloud_config" {
  name      = "${var.vm_name}-cloud-config"
  namespace = var.namespace

  user_data = var.cloud_init_user_data
}