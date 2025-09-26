output "vm_id" {
  description = "ID of the created virtual machine"
  value       = harvester_virtualmachine.vm.id
}

output "vm_name" {
  description = "Name of the created virtual machine"
  value       = harvester_virtualmachine.vm.name
}

output "vm_namespace" {
  description = "Namespace of the virtual machine"
  value       = harvester_virtualmachine.vm.namespace
}

output "vm_state" {
  description = "State of the virtual machine"
  value       = harvester_virtualmachine.vm.state
}

output "vm_node_name" {
  description = "Node where the VM is running (from VM object)"
  value       = harvester_virtualmachine.vm.node_name
}

output "network_interfaces" {
  description = "Network interfaces of the virtual machine"
  value       = harvester_virtualmachine.vm.network_interface
}

output "cloud_config_secret_name" {
  description = "Name of the cloud-init secret"
  value       = harvester_cloudinit_secret.cloud_config.name
}
