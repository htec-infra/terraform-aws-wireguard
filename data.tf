locals {
  display_name = "WireGuard VPN Server"
  cluster_name = "wireguard-vpn-server"

  loggroup_path = "/ecs/wireguard-vpn-server"

  wg_allowed_ips = join(", ", concat(var.wg_allowed_ips, var.wg_ipv4_network))

  subspace_ns = join(",", length(var.subspace_nameservers) > 0 ? var.subspace_nameservers : cidrhost(data.aws_vpc.this.cidr_block, 2))

  envs = {
    SUBSPACE_HTTP_HOST        = local.fqdn
    SUBSPACE_LETSENCRYPT      = true
    SUBSPACE_HTTP_INSECURE    = false
    SUBSPACE_HTTP_ADDR        = ":80"
    SUBSPACE_LISTENPORT       = 51820
    SUBSPACE_IPV6_NAT_ENABLED = 0
    SUBSPACE_DISABLE_DNS      = true
    SUBSPACE_NAMESERVER       = local.subspace_ns
    SUBSPACE_IPV4_POOL        = var.wg_ipv4_network
    SUBSPACE_ALLOWED_IPS      = local.wg_allowed_ips
    SUBSPACE_THEME            = var.subspace_theme
  }
}

data "aws_region" "current" {}

data "aws_availability_zones" "this" {}

data "aws_subnet" "this" {
  id = var.subnet_ids[0]
}

data "aws_vpc" "this" {
  id = data.aws_subnet.this.vpc_id
}
