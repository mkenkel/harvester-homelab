variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace for the VM"
  type        = string
  default     = "default"
}

variable "description" {
  description = "Description of the virtual machine"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to assign to the virtual machine"
  type        = map(string)
  default     = {}
}

variable "cpu_cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Amount of memory in GB"
  type        = string
  default     = "4Gi"
}

variable "disk_size" {
  description = "Size of the root disk"
  type        = string
  default     = "40Gi"
}

variable "vm_image" {
  description = "VM image to use for deployment"
  type        = string
}

variable "network_name" {
  description = "Name of the network to connect the VM to"
  type        = string
  default     = "default/untagged"
}

variable "storage_class" {
  description = "Storage class for the VM disk"
  type        = string
  default     = "longhorn"
}

variable "cloud_init_user_data" {
  description = "Cloud-init user data for VM initialization"
  type        = string
}

variable "hostname" {
  description = "Hostname for the virtual machine"
  type        = string
  default     = ""
}

variable "efi" {
  description = "Enable EFI boot"
  type        = bool
  default     = false
}

variable "secure_boot" {
  description = "Enable secure boot"
  type        = bool
  default     = false
}

variable "run_strategy" {
  description = "Run strategy for the VM"
  type        = string
  default     = "RerunOnFailure"
}

variable "restart_after_update" {
  description = "Restart VM after update"
  type        = bool
  default     = true
}

variable "reserved_memory" {
  description = "Reserved memory for the VM"
  type        = string
  default     = ""
}

variable "machine_type" {
  description = "Machine type for the VM"
  type        = string
  default     = ""
}

variable "wait_for_lease" {
  description = "Wait for network lease"
  type        = bool
  default     = true
}
