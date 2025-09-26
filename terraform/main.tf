# Configure Harvester provider
provider "harvester" {
  kubeconfig = var.kubeconfig_path
}

# Load cloud-init configuration
locals {
  ubuntu_cloud_init_user_data    = file("${path.module}/cloud-init/ubuntu/user-data.yaml")
  ubuntu_cloud_init_network_data = file("${path.module}/cloud-init/ubuntu/network-data.yaml")
}

# Load all the Harvester Defaults
module "harvester-base" {
  source          = "./modules/harvester-base"
  ci_user_data    = local.ubuntu_cloud_init_user_data
  ci_network_data = local.ubuntu_cloud_init_network_data
}

# Launch a Rancher VM
module "rancher-single-node" {
  source     = "./modules/rancher-single-node"
  depends_on = [module.harvester-base]

  vm_name = "rancher-single-node"
  # hostname     = var.hostname
  disk_size               = "20Gi"
  description             = "Rancher Single Node VM"
  cpu                     = "2"
  memory                  = "4Gi"
  image                   = module.harvester-base.ubuntu_2404_image
  namespace               = "harvester-public"
  network_name            = module.harvester-base.server_vlan_network
  storage_class           = "longhorn"
  cloud_init_user_data    = local.ubuntu_cloud_init_user_data
  cloud_init_network_data = local.ubuntu_cloud_init_network_data

  tags = {
    environment = "dev"
    project     = "harvester-homelab"
    os          = "ubuntu"
  }
}
