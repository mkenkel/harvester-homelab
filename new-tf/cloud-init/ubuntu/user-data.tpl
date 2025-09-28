---
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
    ${ssh_key}
package_update: true
package_upgrade: true
packages:
  - qemu-guest-agent
  - openssh-server
# Services to enable
runcmd:
  - - systemctl
    - enable
    - --now
    - qemu-guest-agent.service
  - systemctl enable ssh
  - systemctl start ssh
# Timezone
timezone: UTC
