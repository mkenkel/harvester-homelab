variable "kubeconfig_path" {
  description = "Path to the kubeconfig file for Harvester cluster"
  type        = string
  default     = "~/.kube/config"
}
