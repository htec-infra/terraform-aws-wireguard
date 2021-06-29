# WireGuard&reg; Terraform module

The WireGuard&reg; terraform module combines WireGuard&reg; kernel module (core component) and
[Subspace UI](https://github.com/subspacecommunity/subspace) utilized to manage WireGuard's Peer keys, 
to provide high-available VPN server with the self-service user portal.

# Overview

This module utilizes AWS ECS platform and ASG (AutoScalingGroup) in order to provide scalable API, 
AWS EFS to store peer keys and Route53 to route the network traffic globally. 
In order to provide high security standard, in-transit encryption is enabled both for
internet (between clients and a server) and intra-net communication (between a server and EFS). 
Moreover, EFS encrypts data at-rest and allows access only to a WireGuard's ECS instance.

### Features

- Self-healing WireGuard/Subspace API
- MultiAZ scaling support
- Encrypted and HighAvailable EFS (regional) storage
- Subspace UI with self-service option (SAML authentication must be enabled) 

### Security Disclaimer
Although we aim to achieve the highest data security standards, we are aware that our approach 
has certain drawbacks, so please use this module with caution.

# Usage
```
module "vpn" {
  source = "../"

  # General settings, used for resource identifiers and tags
  namespace   = "Project"
  env_code    = "ops"
  environment = "Operations"
  cost_center = "Infrastructure"

  # domain configuration:
  # fqdn = subspace_subdomain.root_domain = vpn.example.com
  subspace_subdomain = "vpn"
  root_domain        = "example.com"

  # subnet must be in the public subnet
  subnet_ids = ["subnet-public12345"]

  # wireguard internal network CIDR.
  # NOTE: DO NOT overlap Wireguard network CIDR with the AWS VPC network CIDR
  wg_ipv4_network = "10.250.0.0/24"
}
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
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_cloudwatch_log_group.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_cluster.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.wg_subspace](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.wg_subspace](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_efs_file_system.wg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.wg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_eip.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_iam_instance_profile.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.inline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.vpn_container_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.vpn_ssm_core](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_launch_template.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_route53_record.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.wg_efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_password.handler_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_ami.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_iam_policy_document.inline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route53_zone.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [template_cloudinit_config.user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/cloudinit_config) | data source |
| [template_file.taskdef_wg](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_cost_center"></a> [cost\_center](#input\_cost\_center) | Resource tag for easier billing search and reports | `string` | n/a | yes |
| <a name="input_env_code"></a> [env\_code](#input\_env\_code) | Short environment name tag (e.g. dev, stg, prod) | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Full environment name tag (e.g. Development, Staging, Production) | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type | `string` | `"t3.micro"` | no |
| <a name="input_logs_retention_period"></a> [logs\_retention\_period](#input\_logs\_retention\_period) | Number of days how long the WireGuard logs will be kept in the CloudWatch storage. | `number` | `90` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Project namespace | `any` | n/a | yes |
| <a name="input_per_region_domain_name"></a> [per\_region\_domain\_name](#input\_per\_region\_domain\_name) | Per region domain name means that Subspace UI domain will be accessible on vpn.<region>.<root\_domain> instead of regular vpn.<root\_domain> | `bool` | `false` | no |
| <a name="input_root_domain"></a> [root\_domain](#input\_root\_domain) | Domain name used to generate URL for Subspace UI | `string` | n/a | yes |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | List of Security Groups associated to the Wireguard instance | `list(string)` | `[]` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | VPC subnet(s) identifier where to instantiate VPN server. Min 1 subnet id is required | `list(string)` | n/a | yes |
| <a name="input_subspace_container_cpu"></a> [subspace\_container\_cpu](#input\_subspace\_container\_cpu) | n/a | `number` | `1500` | no |
| <a name="input_subspace_container_memory"></a> [subspace\_container\_memory](#input\_subspace\_container\_memory) | n/a | `number` | `725` | no |
| <a name="input_subspace_image"></a> [subspace\_image](#input\_subspace\_image) | Subspace UI docker image | `string` | `"subspacecommunity/subspace"` | no |
| <a name="input_subspace_nameservers"></a> [subspace\_nameservers](#input\_subspace\_nameservers) | n/a | `list(string)` | `[]` | no |
| <a name="input_subspace_subdomain"></a> [subspace\_subdomain](#input\_subspace\_subdomain) | n/a | `string` | `"vpn"` | no |
| <a name="input_subspace_theme"></a> [subspace\_theme](#input\_subspace\_theme) | n/a | `string` | `"green"` | no |
| <a name="input_subspace_version"></a> [subspace\_version](#input\_subspace\_version) | Version of the Subspace UI docker image. | `string` | `"1.5.0"` | no |
| <a name="input_wg_allowed_ips"></a> [wg\_allowed\_ips](#input\_wg\_allowed\_ips) | CIDR format of allowed ip addresses used on the WireGuard client to route the traffic correctly. By default, VPC CIDR will be used. | `list(string)` | `[]` | no |
| <a name="input_wg_ipv4_network"></a> [wg\_ipv4\_network](#input\_wg\_ipv4\_network) | Internal VPN network space utilized by Wireguard server to maintain clients' identifiers. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpn_fqdn"></a> [vpn\_fqdn](#output\_vpn\_fqdn) | n/a |
| <a name="output_vpn_sg_id"></a> [vpn\_sg\_id](#output\_vpn\_sg\_id) | n/a |
<!-- END_TF_DOCS -->
