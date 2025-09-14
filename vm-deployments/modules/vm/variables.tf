variable "vm_name" {
  description = "Name for the virtual machine"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$", var.vm_name))
    error_message = "VM name must follow Kubernetes naming conventions (lowercase alphanumeric and hyphens only)."
  }
}

variable "vm_namespace" {
  description = "Kubernetes namespace for the VM"
  type        = string
  default     = "default"

  validation {
    condition     = can(regex("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$", var.vm_namespace))
    error_message = "Namespace must follow Kubernetes naming conventions."
  }
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

  validation {
    condition     = can(regex("^[^/]+/[^/]+$", var.network_name))
    error_message = "Network name must be in format 'namespace/network-name'."
  }
}

variable "image_name" {
  description = "VM image to use (format: namespace/image-name)"
  type        = string
  default     = "default/ubuntu-20.04"

  validation {
    condition     = can(regex("^[^/]+/[^/]+$", var.image_name))
    error_message = "Image name must be in format 'namespace/image-name'."
  }
}

variable "cloud_init_config" {
  description = "Cloud-init configuration for the VM"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to the VM"
  type        = map(string)
  default     = {}
}