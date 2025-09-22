# Harvester L2VlanNetwork resource for Terraform
# Requires the 'harvester' Terraform provider (https://github.com/harvester/terraform-provider-harvester)
terraform {
  required_providers {
    harvester = {
      source  = "harvester/harvester"
      version = "1.6.0"
    }
  }
}

# harvester_network.my_network:
resource "harvester_network" "my_network" {
  cluster_network_name = "mgmt"
  config = jsonencode(
    {
      bridge      = "mgmt-br"
      cniVersion  = "0.3.1"
      ipam        = {}
      name        = "server-vlan"
      promiscMode = true
      type        = "bridge"
      vlan        = 15
    }
  )
  description          = null
  name                 = "server-vlan"
  namespace            = "default"
  route_dhcp_server_ip = null
  route_mode           = "auto"
  tags                 = {}
  vlan_id              = 15

  timeouts {}

}

resource "harvester_clusternetwork" "my_clusternetwork" {
  description = "Yep."
  name        = "nutcluster"
  tags        = {}

  timeouts {}

}
