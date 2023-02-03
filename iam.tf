resource "aws_iam_instance_profile" "vpn" {
  name_prefix = "WgVpnInstanceProfile"
  role        = aws_iam_role.vpn.name
}

resource "aws_iam_role" "vpn" {
  name_prefix        = "${local.iam_prefix}WgVpnInstanceProfile"
  assume_role_policy = data.aws_iam_policy_document.vpn.json
}

resource "aws_iam_role_policy_attachment" "vpn_ssm_core" {
  role       = aws_iam_role.vpn.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "vpn_container_service" {
  role       = aws_iam_role.vpn.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
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

resource "aws_iam_role_policy" "inline" {
  name_prefix = "CustomPermissions-"
  role        = aws_iam_role.vpn.id
  policy      = data.aws_iam_policy_document.inline.json
}

data "aws_iam_policy_document" "inline" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeAddresses",
      "ec2:AssociateAddress"
    ]
    resources = ["arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:address/*"]
  }
}
