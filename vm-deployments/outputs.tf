output "vm_id" {
  description = "The ID of the created virtual machine"
  value       = module.ubuntu_vm.vm_id
}

output "vm_name" {
  description = "The name of the created virtual machine"
  value       = module.ubuntu_vm.vm_name
}

output "vm_namespace" {
  description = "The namespace of the virtual machine"
  value       = module.ubuntu_vm.vm_namespace
}

output "vm_ip_address" {
  description = "The IP address assigned to the VM (may take time to appear)"
  value       = module.ubuntu_vm.vm_ip_address
}

output "vm_status" {
  description = "The current status of the virtual machine"
  value       = module.ubuntu_vm.vm_status
}

output "connection_info" {
  description = "Connection information for the VM"
  value = {
    ssh_command = module.ubuntu_vm.vm_ip_address != "" ? "ssh ubuntu@${module.ubuntu_vm.vm_ip_address}" : "IP address not yet assigned"
    vm_console  = "Access via Harvester UI for console access"
  }
}