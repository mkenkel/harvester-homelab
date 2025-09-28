################
# SSH Keys
################
resource "harvester_ssh_key" "muhkeys" {
  name       = "matt"
  namespace  = "default"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO1DeBLMgyWMaA6/wc4e3JzMjGEuS4Zjz5Mohd7nD0EJ matt@upshot"
}
