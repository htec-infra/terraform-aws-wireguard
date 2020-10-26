resource "aws_iam_instance_profile" "vpn" {
  name = "WgVpnInstanceProfile"
  role = aws_iam_role.vpn.name
}

resource "aws_iam_role" "vpn" {
  name               = "WgVpnInstanceProfile"
  assume_role_policy = data.aws_iam_policy_document.vpn.json
}

resource "aws_iam_role_policy_attachment" "vpn_ssm_core" {
  role       = aws_iam_role.vpn.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy_document" "vpn" {
  statement {
    sid = "AssumeRoleForEC2"

    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}

