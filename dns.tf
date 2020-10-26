data "aws_route53_zone" "main" {
  name = var.root_domain
}

locals {
  domain_prefix = var.per_region_domain_name ? "vpn.${data.aws_region.current.name}" : "vpn"
  fqdn          = format("%s.%s", local.domain_prefix, var.root_domain)
}

resource "aws_route53_record" "vpn" {
  name    = local.domain_prefix
  zone_id = data.aws_route53_zone.main.zone_id
  type    = "A"
  ttl     = 900

  records = [aws_eip.vpn.public_ip]

  allow_overwrite = true
}
