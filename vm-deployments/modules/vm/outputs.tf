output "vm_id" {
  description = "The ID of the created virtual machine"
  value       = harvester_virtualmachine.vm.id
}

output "vm_name" {
  description = "The name of the created virtual machine"
  value       = harvester_virtualmachine.vm.name
}

output "vm_namespace" {
  description = "The namespace of the virtual machine"
  value       = harvester_virtualmachine.vm.namespace
}

output "vm_ip_address" {
  description = "The IP address assigned to the VM"
  value       = try(harvester_virtualmachine.vm.network_interface[0].ip_address, "")
}

output "vm_mac_address" {
  description = "The MAC address of the VM's network interface"
  value       = try(harvester_virtualmachine.vm.network_interface[0].mac_address, "")
}

output "vm_status" {
  description = "The current status of the virtual machine"
  value       = harvester_virtualmachine.vm.state
}

output "vm_cpu" {
  description = "Number of CPU cores allocated to the VM"
  value       = harvester_virtualmachine.vm.cpu
}

output "vm_memory" {
  description = "Amount of memory allocated to the VM"
  value       = harvester_virtualmachine.vm.memory
}

output "vm_disk_size" {
  description = "Size of the VM's root disk"
  value       = harvester_virtualmachine.vm.disk[0].size
}

output "vm_hostname" {
  description = "The hostname of the virtual machine"
  value       = harvester_virtualmachine.vm.hostname
}