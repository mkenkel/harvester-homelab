variable "kubeconfig_path" {
  description = "Path to the kubeconfig file for Harvester cluster"
  type        = string
  default     = "~/.kube/config"
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
  default     = "ubuntu-vm"
}

variable "namespace" {
  description = "Kubernetes namespace for the VM"
  type        = string
  default     = "default"
}

variable "environment" {
  description = "Environment tag (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "cpu_cores" {
  description = "Number of CPU cores for the VM"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Amount of memory for the VM"
  type        = string
  default     = "4Gi"
}

variable "disk_size" {
  description = "Size of the root disk"
  type        = string
  default     = "40Gi"
}

variable "ubuntu_image" {
  description = "Ubuntu image to use for VM deployment"
  type        = string
  default     = "default/ubuntu-20.04-server-cloudimg-amd64"
}

variable "network_name" {
  description = "Name of the network to connect the VM to"
  type        = string
  default     = "default/untagged"
}

variable "storage_class" {
  description = "Storage class for VM disks"
  type        = string
  default     = "longhorn"
}

variable "vm_hostname" {
  description = "Hostname for the virtual machine"
  type        = string
  default     = "ubuntu-vm"
}

variable "additional_vms" {
  description = "Map of additional VMs to create"
  type = map(object({
    description = string
    hostname    = string
    cpu_cores   = number
    memory      = string
    disk_size   = string
    tags        = map(string)
  }))
  default = {}
}

# Example of additional_vms usage:
# additional_vms = {
#   "web-server" = {
#     description = "Web server VM"
#     hostname    = "web-server"
#     cpu_cores   = 4
#     memory      = "8Gi"
#     disk_size   = "80Gi"
#     tags = {
#       role = "web-server"
#       tier = "frontend"
#     }
#   }
#   "database" = {
#     description = "Database server VM"
#     hostname    = "database"
#     cpu_cores   = 8
#     memory      = "16Gi"
#     disk_size   = "200Gi"
#     tags = {
#       role = "database"
#       tier = "backend"
#     }
#   }
# }