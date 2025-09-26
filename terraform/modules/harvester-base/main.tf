################
# VM Images
################

resource "harvester_image" "ubuntu_2404" {
  name         = "ubuntu-2404"
  namespace    = "default"
  display_name = "Ubuntu 24.04 - Minimal"
  source_type  = "download"
  url          = "https://cloud-images.ubuntu.com/minimal/releases/noble/release/ubuntu-24.04-minimal-cloudimg-amd64.img"
}

resource "harvester_image" "debian_12" {
  name         = "debian-12"
  namespace    = "default"
  display_name = "Debian 12 - Generic Cloud"
  source_type  = "download"
  url          = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2"
}

resource "harvester_image" "debian_13" {
  name         = "debian-13"
  namespace    = "default"
  display_name = "Debian 13 - Generic Cloud"
  source_type  = "download"
  url          = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-genericcloud-amd64.qcow2"
}

resource "harvester_image" "rockylinux_8" {
  name         = "rockylinux-8"
  namespace    = "default"
  display_name = "Rocky Linux 8 - Generic Cloud"
  source_type  = "download"
  url          = "https://download.rockylinux.org/pub/rocky/8/images/x86_64/Rocky-8-GenericCloud.latest.x86_64.qcow2"
}

resource "harvester_image" "rockylinux_9" {
  name         = "rockylinux-9"
  namespace    = "default"
  display_name = "Rocky Linux 9 - Generic Cloud"
  source_type  = "download"
  url          = "https://download.rockylinux.org/pub/rocky/9/images/x86_64/Rocky-9-GenericCloud.latest.x86_64.qcow2"
}

################
# SSH Keys
################

resource "harvester_ssh_key" "mattskeys" {
  name       = "matt"
  namespace  = "default"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO1DeBLMgyWMaA6/wc4e3JzMjGEuS4Zjz5Mohd7nD0EJ matt@upshot"
}

################
# Networking
################

resource "harvester_network" "server-vlan" {
  cluster_network_name = "mgmt"
  name                 = "server-vlan"
  description          = "Server VLAN... For servers."
  namespace            = "harvester-public"
  route_mode           = "auto"
  vlan_id              = 15
}

resource "harvester_clusternetwork" "cluster-net" {
  name        = "nutcluster"
  description = "Container Cluster Network... If only I had more NIC Ports....."
}

################
# Cloud-Init (Currently stored Under Advanced >> Secrets)
################

resource "harvester_cloudinit_secret" "cloud-config-ubuntu" {
  name         = "cloud-config-ubuntu"
  namespace    = "harvester-public"
  user_data    = var.ci_user_data
  network_data = var.ci_network_data
}
