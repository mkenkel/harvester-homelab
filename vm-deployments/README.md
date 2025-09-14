# Harvester VM Deployments with Terraform

This directory contains Terraform configurations for deploying virtual machines on Harvester using the Harvester Terraform provider.

## Prerequisites

1. **Harvester Cluster**: A running Harvester cluster with network access
2. **Terraform**: Install Terraform (>= 1.0)
3. **Harvester Terraform Provider**: The configuration will automatically download the provider

## Usage

### Quick Start

1. **Clone and Navigate**:
   ```bash
   git clone <repository-url>
   cd harvester-homelab/vm-deployments
   ```

2. **Configure Variables**:
   Copy and modify the variables for your environment:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your Harvester cluster details
   ```

3. **Initialize Terraform**:
   ```bash
   terraform init
   ```

4. **Plan Deployment**:
   ```bash
   terraform plan
   ```

5. **Deploy VM**:
   ```bash
   terraform apply
   ```

### Configuration

#### Required Variables

- `harvester_kubeconfig_path`: Path to your Harvester kubeconfig file
- `vm_namespace`: Kubernetes namespace for the VM (default: "default")
- `vm_name`: Name for the virtual machine
- `vm_cpu`: Number of CPU cores
- `vm_memory`: Amount of memory (e.g., "4Gi")
- `vm_disk_size`: Root disk size (e.g., "20Gi")

#### Optional Variables

- `network_name`: Network to attach the VM to (default: "default/vlan1")
- `image_name`: VM image to use (default: "default/ubuntu-20.04")
- `ssh_public_key`: SSH public key for access

### Example terraform.tfvars

```hcl
harvester_kubeconfig_path = "~/.kube/config"
vm_namespace = "default"
vm_name = "ubuntu-vm-01"
vm_cpu = 2
vm_memory = "4Gi"
vm_disk_size = "20Gi"
network_name = "default/vlan1"
image_name = "default/ubuntu-20.04"
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAA... user@hostname"
```

## File Structure

```
vm-deployments/
├── README.md                 # This file
├── main.tf                   # Main Terraform configuration
├── variables.tf              # Input variables
├── outputs.tf                # Output values
├── terraform.tfvars.example  # Example variables file
├── cloud-init/
│   └── ubuntu.yaml          # Cloud-init configuration for Ubuntu
└── modules/
    └── vm/
        ├── main.tf          # Reusable VM module
        ├── variables.tf     # Module variables
        └── outputs.tf       # Module outputs
```

## Cloud-Init Configuration

The `cloud-init/ubuntu.yaml` file contains the cloud-init configuration that will be applied to the VM during first boot. It includes:

- Package updates
- SSH key configuration
- Basic security hardening
- Docker installation (optional)

Modify this file to customize the VM setup according to your needs.

## VM Module

The `modules/vm/` directory contains a reusable Terraform module for creating VMs. This module can be used multiple times to create different VMs with varying configurations.

### Module Usage Example

```hcl
module "web_server" {
  source = "./modules/vm"
  
  vm_name = "web-server"
  vm_namespace = "production"
  vm_cpu = 4
  vm_memory = "8Gi"
  vm_disk_size = "40Gi"
  cloud_init_config = file("./cloud-init/ubuntu.yaml")
  network_name = "default/vlan1"
  image_name = "default/ubuntu-20.04"
}
```

## Troubleshooting

### Common Issues

1. **Authentication Error**: Ensure your kubeconfig file is valid and accessible
2. **Network Issues**: Verify the network name exists in your Harvester cluster
3. **Image Not Found**: Check that the specified image exists and is available
4. **Resource Constraints**: Ensure your cluster has sufficient resources (CPU, memory, storage)

### Logs and Debugging

- Check Terraform logs: `TF_LOG=DEBUG terraform apply`
- View VM status in Harvester UI or via kubectl
- Check cloud-init logs on the VM: `sudo cloud-init status --long`

## Security Considerations

- Store kubeconfig files securely and limit access
- Use SSH keys instead of passwords for VM access
- Regularly update VM images and apply security patches
- Consider using Harvester's network policies for isolation

## Contributing

When contributing to this configuration:

1. Test changes in a development environment first
2. Follow Terraform best practices and formatting
3. Update documentation for any new variables or features
4. Validate configurations with `terraform validate` and `terraform plan`