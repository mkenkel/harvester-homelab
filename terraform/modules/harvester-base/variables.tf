variable "ubuntu" {
  description = "Personal Configurations for Ubuntu's Cloud-Init"
  type = object({
    name         = string
    user_data    = string
    network_data = string
  })
  default = {
    name         = "ubuntu"
    user_data    = "../../cloud-init/ubuntu.yaml"
    network_data = ""
  }
}
