# Nutanix Cluster on Equinix Metal

This Terraform module will deploy a demonstrative Nutanix Cluster in Layer 2 isolation on Equinix Metal. The cluster IPAM and Internet Access is managed by a Rocky bastion/gateway node.

## Acronyms and Terms

* AOS: Acropolis Operating System
* NOS: Nutanix Operating System (Used interchangably with AOS)
* AHV: AOS Hypervisor
* Phoenix: The AOS/NOS Installer
* CVM: Cluster Virtual Machine
* Prism: AOS Cluster Web UI

## Nutanix Installation in a nutshell

For those who are unfamiliar with Nutanix. Nutanix is a virtual machine management suite, similar to VMWare ESXi.

Nutanix is typically deployed in a private network without public IPs assigned directly to the host.
This experience is different than what many cloud users would expect in an OS deployment.

Due to this, we'll be deploying Nutanix with only private management IPs and later converting the nodes to full Layer-2.

To allow access to the internet and make it easier to access these hosts, we'll be deploying a server in Hybrid networking mode to act as a router and jump box.

To begin, we'll start by provisioning a c3.small which has two NICs. Allowing us to have one in layer-3 with a public IP,
and one in layer-2 to access the internal layer-2 network.

## Manual Installation

See [INSTALL_GUIDE.md](INSTALL_GUIDE.md) to install by hand. Otherwise, skip to the following section to let Terraform do all the work.

## Terraform installation

```sh
terraform init
eval $(metal env -o terraform --export)
terraform apply
```

### Login

```sh
touch nutanix_rsa
chmod 0600 nutanix_rsa
terraform output -raw ssh_private_key > nutanix_rsa
ssh -i nutanix_rsa root@$(terraform out -raw bastion_public_ip)
```

## Examples

To view examples for how you can leverage this module, please see the [examples](examples/) directory.

<!-- TEMPLATE: The following block has been generated by terraform-docs util: https://github.com/terraform-docs/terraform-docs -->
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [equinix_metal_device.bastion](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_device) | resource |
| [equinix_metal_device.nutanix](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_device) | resource |
| [equinix_metal_port.bastion_bond0](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_port) | resource |
| [equinix_metal_port.nutanix_bond0](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_port) | resource |
| [equinix_metal_vlan.test](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_vlan) | resource |
| [equinix_metal_project.nutanix](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/metal_project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_metal_auth_token"></a> [metal\_auth\_token](#input\_metal\_auth\_token) | n/a | `any` | n/a | yes |
| <a name="input_metal_vlan_description"></a> [metal\_vlan\_description](#input\_metal\_vlan\_description) | n/a | `string` | `"ntnx-demo"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
## Contributing

If you would like to contribute to this module, see [CONTRIBUTING](CONTRIBUTING.md) page.

## License

Apache License, Version 2.0. See [LICENSE](LICENSE).
