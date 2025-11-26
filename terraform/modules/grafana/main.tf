resource "aws_ecs_task_definition" "grafana" {
  family                   = var.task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory

  container_definitions = jsonencode([
    {
      name      = "grafana"
      image     = var.image
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "GF_SECURITY_ADMIN_USER"
          value = var.admin_user
        },
        {
          name  = "GF_SECURITY_ADMIN_PASSWORD"
          value = var.admin_password
        },
        {
          name  = "GF_SERVER_ROOT_URL"
          value = var.root_url
        },
        {
          name  = "GF_SECURITY_ALLOW_EMBEDDING"
          value = "true"
        },
        {
          name  = "PROMETHEUS_URL"
          value = var.prometheus_url
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.log_group
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "grafana"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "grafana" {
  name            = var.service_name
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.grafana.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = var.security_group_ids
    assign_public_ip = true
  }
}
