## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| context | n/a | `any` | n/a | yes |
| cost\_center | n/a | `string` | n/a | yes |
| create\_vpn | n/a | `bool` | `false` | no |
| environment | n/a | `string` | n/a | yes |
| iam\_prefix | n/a | `string` | n/a | yes |
| instance\_type | EC2 instance type | `string` | `"t3.micro"` | no |
| key\_pair\_name | EC2 instance keyname that can be used for SSH access directly to the EC2 instance or as a Jump host as a VPN alternative. | `string` | `""` | no |
| per\_region\_domain\_name | Per region domain name means that Subspace UI domain will be accessible on vpn.<region>.<root\_domain> instead of regular vpn.<root\_domain> | `bool` | `false` | no |
| root\_domain | Domain name used to generate URL for Subspace UI | `string` | n/a | yes |
| security\_group\_id | List of Security Groups associated to the Wireguard instance | `list(string)` | `[]` | no |
| subspace\_allowed\_ips | CIDR format of allowed ip addresses used on the Wireguard client to route the traffic correctly. | `string` | `"0.0.0.0/0"` | no |
| subspace\_ipv4\_network | Internal VPN network space | `any` | n/a | yes |
| subspace\_version | Version of the Subspace UI docker image. | `string` | `"1.3.1"` | no |
| vpc\_id | VPC used to instantiate EC2 for VPN server | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| vpn\_fqdn | n/a |
| vpn\_sg\_id | n/a |

