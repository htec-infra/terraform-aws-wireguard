data "aws_region" "current" {}

data "aws_availability_zones" "this" {}

data "aws_subnet_ids" "public" {
  vpc_id = var.vpc_id

  tags = {
    Tier = "Public"
  }
}

data "aws_subnet" "public" {
  count = 3
  id    = tolist(data.aws_subnet_ids.public.ids)[count.index]
}

data "template_cloudinit_config" "userdata" {
  gzip          = true
  base64_encode = true

  # Install and configure wireguard
  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/scripts/setup_wireguard.sh.tpl", {})
  }

  # Install docker
  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/scripts/setup_docker.sh.tpl", {})
  }

  # Setup Subspace UI for Wireguard (via Docker)
  part {
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/scripts/setup_subspace.sh.tpl", {
      subspace_http_host    = local.fqdn,
      subspace_ipv4_network = var.subspace_ipv4_network,
      subspace_version      = var.subspace_version,
      subspace_allowed_ips  = var.subspace_allowed_ips
    })
  }
}