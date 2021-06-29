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
