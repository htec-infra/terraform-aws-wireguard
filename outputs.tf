output "vpn_sg_id" {
  value = aws_security_group.vpn.id
}

output "vpn_fqdn" {
  value = aws_route53_record.vpn.fqdn
}