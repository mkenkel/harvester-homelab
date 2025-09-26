resource "harvester_virtualmachine" "rancher-single-node" {
  # hostname = var.hostname
  name         = var.vm_name
  namespace    = var.namespace
  description  = var.description
  cpu          = var.cpu
  memory       = var.memory
  run_strategy = "RerunOnFailure"
  tags         = var.tags

  ssh_keys = [
    var.ssh_public_key
  ]

  disk {
    access_mode = "ReadWriteOnce"
    boot_order  = 1
    bus         = "virtio"
    image       = var.image
    name        = "rootdisk"
    size        = var.disk_size
    volume_mode = "Block"
    auto_delete = true
    hot_plug    = false
  }

  network_interface {
    name         = "eth0"
    network_name = var.network_name
  }

  cloudinit {
    user_data    = var.cloud_init_user_data
    network_data = var.cloud_init_network_data
  }
}
