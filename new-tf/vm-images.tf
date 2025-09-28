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
