output "vm_id" {
  description = "ID of the created virtual machine"
  value       = harvester_virtualmachine.rancher-single-node.id
}

output "vm_name" {
  description = "Name of the created virtual machine"
  value       = harvester_virtualmachine.rancher-single-node.name
}

output "vm_namespace" {
  description = "Namespace of the virtual machine"
  value       = harvester_virtualmachine.rancher-single-node.namespace
}

output "vm_state" {
  description = "State of the virtual machine"
  value       = harvester_virtualmachine.rancher-single-node.state
}

output "vm_node_name" {
  description = "Node where the VM is running (from VM object)"
  value       = harvester_virtualmachine.rancher-single-node.node_name
}

output "network_interfaces" {
  description = "Network interfaces of the virtual machine"
  value       = harvester_virtualmachine.rancher-single-node.network_interface
}
