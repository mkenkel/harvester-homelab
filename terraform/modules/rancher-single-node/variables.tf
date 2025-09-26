variable "vm_name" {
  description = "Name of the virtual machine."
  type        = string
}

variable "disk_size" {
  description = "Size of the VM root disk (e.g., '20Gi')."
  type        = string
}

variable "storage_class" {
  description = "Storage class to use for the root disk."
  default     = "longhorn"
  type        = string
}

variable "network_name" {
  description = "Name of the network to attach to eth0."
  type        = string
}

variable "cpu" {
  description = "Number of CPUs for the VM."
  type        = number
  default     = 2
}

variable "memory" {
  description = "Amount of memory for the VM (e.g., '4Gi')."
  type        = string
  default     = "4Gi"
}

variable "image" {
  description = "Image to use for the VM."
  type        = string
}

variable "description" {
  description = "Description for the VM."
  type        = string
  default     = ""
}

# variable "hostname" {
#   description = "Hostname for the VM."
#   type        = string
#   default     = ""
# }

variable "namespace" {
  description = "Namespace to deploy the VM in."
  type        = string
}

variable "tags" {
  description = "Tags to assign to the virtual machine"
  type        = map(string)
  default     = {}
}

variable "cloud_init_user_data" {
  description = "Cloud-init user data to configure the VM."
  type        = string
  default     = ""
}

variable "cloud_init_network_data" {
  description = "Cloud-init user data to configure the VM."
  type        = string
  default     = ""
}
