data "template_file" "taskdef_wg" {
  template = file("${path.module}/templates/taskdef-wg.tpl")

  vars = {
    subspace_image   = join(":", [var.subspace_image, var.subspace_version])
    container_cpu    = var.subspace_container_cpu
    container_memory = var.subspace_container_memory
    loggroup_path    = local.loggroup_path
    app_region       = data.aws_region.current.name

    envs = jsonencode([for key, value in local.envs : {
      Name : key,
      Value : tostring(value)
    }])
  }
}

resource "aws_ecs_cluster" "vpn" {
  name = local.cluster_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = merge(var.additional_tags, {
    Environment = var.environment
    Namespace   = var.namespace
  })
}

data "aws_ami" "vpn" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
}


resource "aws_cloudwatch_log_group" "vpn" {
  name = local.loggroup_path

  tags = merge(var.additional_tags, {})
}

resource "aws_ecs_task_definition" "wg_subspace" {
  container_definitions = data.template_file.taskdef_wg.rendered
  family                = "wg-subspace"

  network_mode = "host"

  requires_compatibilities = ["EC2"]

  volume {
    name = "wgdata"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.wg.id
    }
  }

  volume {
    name = "wgdnsmasq"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.wg.id
    }
  }

  tags = merge(var.additional_tags, {})
}


resource "aws_ecs_service" "wg_subspace" {
  name                               = "wg-subspace"
  cluster                            = aws_ecs_cluster.vpn.arn
  task_definition                    = aws_ecs_task_definition.wg_subspace.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100
  launch_type                        = "EC2"

  lifecycle {
    ignore_changes = [desired_count]
  }
}
