# Configure Harvester provider
provider "harvester" {
  kubeconfig = var.kubeconfig_path
}

module "harvester-base" {
  source = "./modules/harvester-base"
}

module "rancher-single-node" {
  source     = "./modules/rancher-single-node"
  depends_on = [module.harvester-base]

  vm_name     = "rancher-sn-deploy"
  hostname    = "rancher-sn-deploy"
  namespace   = "default"
  description = "Rancher VM - Single Node"

  cpu_cores = "2"
  memory    = "4Gi"
  disk_size = "20Gi"

  vm_image             = "ubuntu-2404"
  network_name         = "server-vlan"
  storage_class        = "longhorn"
  cloud_init_user_data = harvester_cloudinit_secret.cloud-config-ubuntu.name


  tags = {
    environment = "dev"
    project     = "harvester-homelab"
    os          = "ubuntu"
  }
}
