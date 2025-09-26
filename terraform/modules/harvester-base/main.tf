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
  description          = "Server VLAN... For servers."
  name                 = "server-vlan"
  namespace            = "harvester-public"
  route_mode           = "auto"
  vlan_id              = 15
}

resource "harvester_clusternetwork" "cluster-net" {
  description = "Yep."
  name        = "nutcluster"
  tags        = {}
}

################
# Cloud-Init (Currently stored Under Advanced >> Secrets)
################

resource "harvester_cloudinit_secret" "cloud-config-ubuntu" {
  name      = "cloud-config-ubuntu"
  namespace = "default"

  user_data = <<EOT

#cloud-config
# User data
users:
  - name: matt
    groups: sudo
    shell: /bin/bash
    sudo: 'ALL=(ALL) NOPASSWD:ALL'
    ssh_authorized_keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO1DeBLMgyWMaA6/wc4e3JzMjGEuS4Zjz5Mohd7nD0EJ matt@upshot
# Package updates and installation
package_update: true
package_upgrade: true
packages:
  - qemu-guest-agent
  - curl
  - wget
  - vim
  - htop
  - net-tools
  - openssh-server
# Services to enable
runcmd:
  - systemctl enable qemu-guest-agent
  - systemctl start qemu-guest-agent
  - systemctl enable ssh
  - systemctl start ssh
# Timezone
timezone: UTC
# Final message
final_message: "The system is finally up, after $UPTIME seconds"
EOT

  network_data = <<EOT
# cloud-config
# Network data
version: 2
ethernets:
  eth0:
    dhcp4: true

EOT
}
