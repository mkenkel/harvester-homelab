variable "harvester_kubeconfig_path" {
  description = "Path to the Harvester kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "vm_namespace" {
  description = "Kubernetes namespace for the VM"
  type        = string
  default     = "default"
}

variable "vm_name" {
  description = "Name for the virtual machine"
  type        = string
}

variable "vm_cpu" {
  description = "Number of CPU cores for the VM"
  type        = number
  default     = 2

  validation {
    condition     = var.vm_cpu >= 1 && var.vm_cpu <= 64
    error_message = "CPU cores must be between 1 and 64."
  }
}

variable "vm_memory" {
  description = "Amount of memory for the VM (e.g., '4Gi', '8Gi')"
  type        = string
  default     = "4Gi"

  validation {
    condition     = can(regex("^[0-9]+[KMGT]i?$", var.vm_memory))
    error_message = "Memory must be specified in Kubernetes format (e.g., '4Gi', '2048Mi')."
  }
}

variable "vm_disk_size" {
  description = "Size of the root disk (e.g., '20Gi', '50Gi')"
  type        = string
  default     = "20Gi"

  validation {
    condition     = can(regex("^[0-9]+[KMGT]i?$", var.vm_disk_size))
    error_message = "Disk size must be specified in Kubernetes format (e.g., '20Gi', '100Gi')."
  }
}

variable "network_name" {
  description = "Network to attach the VM to (format: namespace/network-name)"
  type        = string
  default     = "default/vlan1"
}

variable "image_name" {
  description = "VM image to use (format: namespace/image-name)"
  type        = string
  default     = "default/ubuntu-20.04"
}

variable "ssh_public_key" {
  description = "SSH public key for accessing the VM"
  type        = string
  default     = ""

  validation {
    condition     = var.ssh_public_key == "" || can(regex("^(ssh-rsa|ssh-ed25519|ssh-dss|ecdsa-sha2-nistp256|ecdsa-sha2-nistp384|ecdsa-sha2-nistp521)", var.ssh_public_key))
    error_message = "SSH public key must be a valid SSH public key format."
  }
}