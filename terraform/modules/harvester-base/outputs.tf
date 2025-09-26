output "ubuntu_2404_image" {
  description = "The ID of the Ubuntu 24.04 image"
  value       = harvester_image.ubuntu_2404.id
}

output "debian_12_image" {
  description = "The ID of the Debian 12 image"
  value       = harvester_image.debian_12.id
}

output "debian_13_image" {
  description = "The ID of the Debian 13 image"
  value       = harvester_image.debian_13.id
}

output "rockylinux_8_image" {
  description = "The ID of the Rocky Linux 8 image"
  value       = harvester_image.rockylinux_8.id
}

output "rockylinux_9_image" {
  description = "The ID of the Rocky Linux 9 image"
  value       = harvester_image.rockylinux_9.id
}

output "muhkeys_ssh_key" {
  description = "The ID of My SSH key"
  value       = harvester_ssh_key.muhkeys.name
}

output "server_vlan_network" {
  description = "The ID of the server VLAN network"
  value       = harvester_network.server-vlan.id
}

output "cluster_net_clusternetwork" {
  description = "The ID of the cluster network"
  value       = harvester_clusternetwork.cluster-net.id
}

output "cloud_config_ubuntu_secret" {
  description = "The ID of the cloud-config secret for Ubuntu"
  value       = harvester_cloudinit_secret.cloud-config-ubuntu.name
}
