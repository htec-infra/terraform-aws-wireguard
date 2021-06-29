resource "aws_efs_file_system" "wg" {
  creation_token = local.cluster_name

  encrypted = true

  tags = {
    Name = local.display_name
  }
}

resource "aws_efs_mount_target" "wg" {
  for_each = toset(var.subnet_ids)

  file_system_id  = aws_efs_file_system.wg.id
  security_groups = [aws_security_group.wg_efs.id]
  subnet_id       = each.key
}

resource "aws_security_group" "wg_efs" {
  name_prefix = "wireguard-efs-mount-target-"
  vpc_id      = data.aws_subnet.this.vpc_id

  # Allow NFS port only
  ingress {
    protocol        = "TCP"
    from_port       = 2049
    to_port         = 2049
    security_groups = [aws_security_group.vpn.id]
    description     = "Access from VPN Server only"
  }

  lifecycle {
    create_before_destroy = true
  }
}
