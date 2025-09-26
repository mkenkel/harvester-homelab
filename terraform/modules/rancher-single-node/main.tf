resource "harvester_virtualmachine" "rancher-single-node" {
  # Mando
  name = var.vm_name
  disk = {
    size          = var.disk_size
    storage_class = var.storage_class
  }
  network_interface {
    name         = "eth0"
    network_name = harvester_network.server-vlan.id
  }

  # Optional
  cpu    = "2"
  memory = "4Gi"
  cloudinit = {
    user_data_secret_name = var.cloud_init_user_data
  }

  description = var.description
  # hostname = var.hostname
  namespace = var.namespace
  ssh_keys = [
    harvester_ssh_key.mattskeys.id
  ]

}
