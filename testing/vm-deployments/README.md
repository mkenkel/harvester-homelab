# Harvester VM Deployments with Terraform

This directory contains Terraform configurations for deploying virtual machines on Harvester using Infrastructure as Code (IaC) principles.

## Directory Structure

```
vm-deployments/
├── README.md                # This documentation
├── main.tf                  # Main Terraform configuration
├── variables.tf             # Input variables
├── outputs.tf              # Output values
├── cloud-init/
│   └── ubuntu.yaml         # Cloud-init user-data for Ubuntu VMs
└── modules/
    └── vm/
        ├── main.tf         # VM module main configuration
        ├── variables.tf    # VM module variables
        └── outputs.tf      # VM module outputs
```

## Prerequisites

1. **Harvester Cluster**: A running Harvester cluster with admin access
2. **Terraform**: Version >= 1.0 installed
3. **Kubeconfig**: Valid kubeconfig file for accessing the Harvester cluster
4. **VM Images**: Ubuntu cloud images imported into Harvester

## Quick Start

### 1. Initialize Terraform

```bash
cd vm-deployments
terraform init
```

### 2. Configure Variables

Create a `terraform.tfvars` file with your specific values:

```hcl
kubeconfig_path = "/path/to/your/kubeconfig"
vm_name         = "my-ubuntu-vm"
namespace       = "default"
environment     = "dev"

# VM specifications
cpu_cores = 4
memory    = "8Gi"
disk_size = "60Gi"

# Harvester-specific settings
ubuntu_image     = "default/ubuntu-22.04-server-cloudimg-amd64"
network_name     = "default/mgmt-network"
storage_class    = "longhorn"
```

### 3. Customize Cloud-Init (Optional)

Edit `cloud-init/ubuntu.yaml` to:
- Add your SSH public key
- Configure additional packages
- Set up custom scripts

### 4. Plan and Deploy

```bash
# Review the execution plan
terraform plan

# Deploy the infrastructure
terraform apply
```

## Configuration Options

### VM Module Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `vm_name` | Name of the virtual machine | - | Yes |
| `namespace` | Kubernetes namespace | `default` | No |
| `cpu_cores` | Number of CPU cores | `2` | No |
| `memory` | Amount of memory | `4Gi` | No |
| `disk_size` | Root disk size | `40Gi` | No |
| `vm_image` | VM image to deploy | - | Yes |
| `network_name` | Network to connect VM | `default/untagged` | No |
| `storage_class` | Storage class for disks | `longhorn` | No |

### Advanced Configuration

#### Deploy Multiple VMs

Use the `additional_vms` variable to deploy multiple VMs:

```hcl
additional_vms = {
  "web-server" = {
    description = "Web server VM"
    hostname    = "web-server"
    cpu_cores   = 4
    memory      = "8Gi"
    disk_size   = "80Gi"
    tags = {
      role = "web-server"
      tier = "frontend"
    }
  }
  "database" = {
    description = "Database server VM"
    hostname    = "database"
    cpu_cores   = 8
    memory      = "16Gi"
    disk_size   = "200Gi"
    tags = {
      role = "database"
      tier = "backend"
    }
  }
}
```

#### Custom Cloud-Init

The cloud-init configuration includes:
- SSH key setup for the `ubuntu` user
- Qemu guest agent installation
- Basic package installation and updates
- Network configuration
- System service configuration

## Usage Examples

### Basic Single VM Deployment

```bash
terraform apply -var="vm_name=test-vm" -var="cpu_cores=2" -var="memory=4Gi"
```

### Production Environment

```hcl
# terraform.tfvars
environment     = "prod"
vm_name         = "prod-app-server"
cpu_cores       = 8
memory          = "32Gi"
disk_size       = "200Gi"
ubuntu_image    = "default/ubuntu-22.04-server-cloudimg-amd64"
```

## Cloud-Init Configuration

The `cloud-init/ubuntu.yaml` file configures:

- **User Setup**: Creates an `ubuntu` user with sudo privileges
- **SSH Access**: Configures SSH key authentication
- **Package Management**: Updates system and installs essential packages
- **Services**: Enables qemu-guest-agent and SSH
- **Network**: Configures DHCP networking

### Customizing SSH Keys

Replace the placeholder SSH key in `cloud-init/ubuntu.yaml`:

```yaml
users:
  - name: ubuntu
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC... # Your actual SSH public key
```

## Outputs

After deployment, Terraform provides useful outputs:

- `vm_details`: VM ID, name, namespace, status, and node
- `vm_network_interfaces`: Network interface information
- `cloud_config_secret`: Cloud-init secret name
- `additional_vms`: Details of any additional VMs
- `all_vm_names`: List of all created VM names

## Managing VMs

### Check VM Status

```bash
terraform output vm_details
```

### Update VM Configuration

Modify variables and apply changes:

```bash
terraform apply -var="cpu_cores=4" -var="memory=8Gi"
```

### Destroy VMs

```bash
terraform destroy
```

## Troubleshooting

### Common Issues

1. **Invalid kubeconfig**: Ensure the kubeconfig path is correct and you have access to the Harvester cluster
2. **Image not found**: Verify the VM image name exists in your Harvester cluster
3. **Network issues**: Check that the specified network exists and is accessible
4. **Storage class**: Ensure the storage class is available in your cluster

### Debugging

Enable Terraform debug logging:

```bash
export TF_LOG=DEBUG
terraform apply
```

Check VM status in Harvester UI or via kubectl:

```bash
kubectl get vms -n default
kubectl describe vm <vm-name> -n default
```

## Best Practices

1. **Version Control**: Store your `terraform.tfvars` in a separate file and exclude it from version control
2. **State Management**: Use remote state storage for production environments
3. **Resource Naming**: Use consistent naming conventions for VMs and resources
4. **Tagging**: Apply consistent tags for resource organization and cost tracking
5. **Security**: Regularly rotate SSH keys and keep cloud-init configurations secure

## Contributing

When contributing to this configuration:

1. Validate Terraform syntax: `terraform validate`
2. Format code: `terraform fmt`
3. Test changes in a development environment first
4. Update documentation for new variables or features

## License

This configuration is provided as-is for educational and homelab purposes.