

data "aws_ami" "wgserver" {
  most_recent = true

  filter {
    name   = "name"
    values = ["*ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "vpn" {
  name        = "vpn-server-entry-point"
  description = "Allows SSH, HTTP/HTTPS and WireGuard VPN traffic"
  vpc_id      = data.aws_subnet.this.vpc_id

  ingress {
    protocol         = "TCP"
    from_port        = 22
    to_port          = 22
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = ""
  }

  ingress {
    protocol         = "TCP"
    from_port        = 80
    to_port          = 80
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = ""
  }

  ingress {
    protocol         = "TCP"
    from_port        = 443
    to_port          = 443
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = ""
  }

  ingress {
    protocol         = "UDP"
    from_port        = 51820
    to_port          = 51820
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = ""
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

//resource "aws_instance" "vpn" {
//  ami           = data.aws_ami.wgserver.id
//  instance_type = var.instance_type
//  key_name      = var.key_pair_name
//
//  subnet_id              = data.aws_subnet.public[0].id
//  vpc_security_group_ids = concat(var.security_group_id, [aws_security_group.vpn.id])
//
//  iam_instance_profile = aws_iam_instance_profile.vpn.name
//  user_data_base64     = data.template_cloudinit_config.userdata.rendered
//
//  tags = {
//    Name        = "WireGuard VPN"
//    Context     = var.context
//    CostCenter  = var.cost_center
//    Environment = var.environment
//  }
//
//  lifecycle {
//    ignore_changes = [ami, user_data_base64]
//  }
//}

// TODO: Replace with ASG

resource "aws_eip" "vpn" {
  vpc      = true
  instance = aws_instance.vpn.id

  tags = {
    Name = "WireGuard - VPN Server"
  }
}


