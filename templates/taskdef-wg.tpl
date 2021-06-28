[
  {
    "name": "wgserver",
    "image": "${subspace_image}",
    "cpu": ${container_cpu},
    "memory": ${container_memory},
    "volumesFrom": [],
    "essential": true,
    "environment": ${envs},
    "secrets": [],
    "portMappings": [],
    "mountPoints": [
      {
        "sourceVolume": "wgdata",
        "containerPath": "/data"
      },
      {
        "sourceVolume": "wgdnsmasq",
        "containerPath": "/etc/dnsmasq.d"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${loggroup_path}",
        "awslogs-region": "${app_region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]

