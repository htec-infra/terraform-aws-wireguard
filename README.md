# Wireguard Terraform module

Wireguard module installs the Wireguard VPN Server on the Ubuntu 20.04 AMI along with 
[Subspace UI](https://github.com/subspacecommunity/subspace) that is used to manage Wireguard's Peer keys.

```
Note: This module disables DNS service deployed on the Subspace docker container because of conflicts
with the EC2 system-resolver service.  
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.40 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.40 |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_iam_instance_profile.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.vpn_ssm_core](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_route53_record.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.wgserver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_iam_policy_document.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route53_zone.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [template_cloudinit_config.userdata](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/cloudinit_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cost_center"></a> [cost\_center](#input\_cost\_center) | Resource tag for easier billing search and reports | `string` | n/a | yes |
| <a name="input_env_code"></a> [env\_code](#input\_env\_code) | Short environment name tag (e.g. dev, stg, prod) | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Full environment name tag (e.g. Development, Staging, Production) | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type | `string` | `"t3.micro"` | no |
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | EC2 instance keyname that can be used for SSH access directly to the EC2 instance or as a Jump host as a VPN alternative. | `string` | `""` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Project namespace | `any` | n/a | yes |
| <a name="input_per_region_domain_name"></a> [per\_region\_domain\_name](#input\_per\_region\_domain\_name) | Per region domain name means that Subspace UI domain will be accessible on vpn.<region>.<root\_domain> instead of regular vpn.<root\_domain> | `bool` | `false` | no |
| <a name="input_root_domain"></a> [root\_domain](#input\_root\_domain) | Domain name used to generate URL for Subspace UI | `string` | n/a | yes |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | List of Security Groups associated to the Wireguard instance | `list(string)` | `[]` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | VPC subnet(s) identifier where to instantiate VPN server. Min 1 subnet id is required | `list(string)` | n/a | yes |
| <a name="input_subspace_allowed_ips"></a> [subspace\_allowed\_ips](#input\_subspace\_allowed\_ips) | CIDR format of allowed ip addresses used on the WireGuard client to route the traffic correctly. By default, VPC CIDR will be used. | `list(string)` | `[]` | no |
| <a name="input_subspace_image"></a> [subspace\_image](#input\_subspace\_image) | Subspace UI docker image | `string` | `"subspacecommunity/subspace"` | no |
| <a name="input_subspace_ipv4_network"></a> [subspace\_ipv4\_network](#input\_subspace\_ipv4\_network) | Internal VPN network space utilized by Wireguard server to maintain clients' identifiers. | `any` | n/a | yes |
| <a name="input_subspace_version"></a> [subspace\_version](#input\_subspace\_version) | Version of the Subspace UI docker image. | `string` | `"1.5.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpn_fqdn"></a> [vpn\_fqdn](#output\_vpn\_fqdn) | n/a |
| <a name="output_vpn_sg_id"></a> [vpn\_sg\_id](#output\_vpn\_sg\_id) | n/a |
<!-- END_TF_DOCS -->
