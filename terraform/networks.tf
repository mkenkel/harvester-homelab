################
# Networking
################

resource "harvester_network" "server-vlan" {
  cluster_network_name = "mgmt"
  name                 = "server-vlan"
  description          = "Server VLAN... For servers."
  namespace            = "default"
  route_mode           = "manual"
  route_cidr           = "192.168.150.1/25"
  route_gateway        = "192.168.150.1"
  vlan_id              = 150
}

resource "harvester_clusternetwork" "cluster-net" {
  name        = "nutcluster"
  description = "Container Cluster Network... If only I had more NIC Ports....."
}
