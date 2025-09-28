################
# Networking
################

resource "harvester_network" "server-vlan" {
  cluster_network_name = "mgmt"
  name                 = "server-vlan"
  description          = "Server VLAN... For servers."
  namespace            = "harvester-public"
  route_mode           = "manual"
  route_cidr           = "192.168.15.1/24"
  route_gateway        = "192.168.15.1"
  vlan_id              = 15
}

resource "harvester_clusternetwork" "cluster-net" {
  name        = "nutcluster"
  description = "Container Cluster Network... If only I had more NIC Ports....."
}
