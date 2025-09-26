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
  ci_user_data    = "boobah"
  ci_network_data = "jajajaj"
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
  ssh_public_key          = module.harvester-base.mattskeys_ssh_key
  cloud_init_user_data    = module.harvester-base.cloud_config_ubuntu_secret
  cloud_init_network_data = module.harvester-base.cloud_config_ubuntu_secret

  tags = {
    environment = "dev"
    project     = "harvester-homelab"
    os          = "ubuntu"
  }
}
