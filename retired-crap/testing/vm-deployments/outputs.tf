output "vm_details" {
  description = "Details of the created VM"
  value = {
    id        = module.ubuntu_vm_example.vm_id
    name      = module.ubuntu_vm_example.vm_name
    namespace = module.ubuntu_vm_example.vm_namespace
    state     = module.ubuntu_vm_example.vm_state
    node_name = module.ubuntu_vm_example.vm_node_name
  }
}

output "vm_network_interfaces" {
  description = "Network interfaces of the VM"
  value       = module.ubuntu_vm_example.network_interfaces
}

output "cloud_config_secret" {
  description = "Name of the cloud-init secret"
  value       = module.ubuntu_vm_example.cloud_config_secret_name
}

output "additional_vms" {
  description = "Details of additional VMs created"
  value = {
    for name, vm in module.ubuntu_vms : name => {
      id        = vm.vm_id
      name      = vm.vm_name
      namespace = vm.vm_namespace
      state     = vm.vm_state
      node_name = vm.vm_node_name
    }
  }
}

output "all_vm_names" {
  description = "List of all created VM names"
  value = concat(
    [module.ubuntu_vm_example.vm_name],
    [for vm in module.ubuntu_vms : vm.vm_name]
  )
}