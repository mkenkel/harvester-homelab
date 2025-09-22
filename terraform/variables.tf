variable "kubeconfig_path" {
  description = "Path to the kubeconfig file for Harvester cluster"
  type        = string
  default     = "~/.kube/config"
}

variable "namespace" {
  description = "Kubernetes namespace for the VM"
  type        = string
  default     = "default"
}
