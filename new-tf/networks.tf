################
# Networking
################

resource "harvester_network" "server-vlan" {
  cluster_network_name = "mgmt"
  name                 = "server-vlan"
  description          = "Server VLAN... For servers."
  namespace            = "harvester-public"
  route_mode           = "auto"
  vlan_id              = 15
}

resource "harvester_clusternetwork" "cluster-net" {
  name        = "nutcluster"
  description = "Container Cluster Network... If only I had more NIC Ports....."
}
