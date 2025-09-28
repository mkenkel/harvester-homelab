resource "harvester_virtualmachine" "rancher-single-node" {
  # hostname = var.hostname
  name         = "rancher-single-node"
  namespace    = "harvester-public"
  description  = "Rancher Single Node VM"
  cpu          = "2"
  memory       = "4Gi"
  run_strategy = "RerunOnFailure"
  tags = {
    environment = "dev"
    project     = "harvester-homelab"
    os          = "ubuntu"
  }

  disk {
    access_mode = "ReadWriteOnce"
    boot_order  = 1
    bus         = "virtio"
    image       = harvester_image.ubuntu_2404.id
    name        = "rootdisk"
    size        = "20Gi"
    volume_mode = "Block"
    auto_delete = true
    hot_plug    = false
  }

  network_interface {
    name         = "eth0"
    network_name = harvester_network.server-vlan.id
  }

  cloudinit {
    user_data = <<-EOF
                #cloud-config
                # User data
                users:
                  - name: ubuntu
                    create_home: true
                    groups: sudo
                    home: /home/ubuntu
                    lock_passwd: false
                    passwd_expire: false
                    plain_text_passwd: ubuntu
                    shell: /bin/bash
                    sudo: 'ALL=(ALL) NOPASSWD:ALL'
                    ssh_authorized_keys:
                      - >-
                        ${trimspace(resource.harvester_ssh_key.muhkeys.public_key)}
                hostname: rancher-single-node
                manage_etc_hosts: true
                package_upgrade: true
                packages:
                  - qemu-guest-agent
                  - vim
                  - docker.io
                  - apt-transport-https
                  - ca-certificates
                  - curl
                  - gnupg
                  - lsb-release
                runcmd:
                  - - systemctl
                    - enable
                    - --now
                    - qemu-guest-agent.service
                  - systemctl enable docker
                  - systemctl start docker
                  - curl -fsSL https://get.docker.com | sh
                  - curl -fsSL https://releases.rancher.com/install-docker/20.10.sh | sh
                  - systemctl enable docker
                  - systemctl start docker
                  - docker run -d --restart=unless-stopped -p 80:80 -p 443:443 --privileged rancher/rancher:latest 
                EOF
  }
}
