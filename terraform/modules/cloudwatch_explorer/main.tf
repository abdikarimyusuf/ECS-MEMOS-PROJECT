resource "aws_ecs_task_definition" "cloudwatch_exporter" {
  family                   = var.task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory

  container_definitions = jsonencode([
    {
      name      = "cloudwatch-exporter"
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
          name  = "AWS_REGION"
          value = var.aws_region
        },
        {
          name  = "CONFIG_S3_BUCKET"
          value = var.s3_bucket
        },
        {
          name  = "CONFIG_S3_KEY"
          value = var.s3_key
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.log_group
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "cloudwatch-exporter"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "cloudwatch_exporter" {
  name            = var.service_name
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.cloudwatch_exporter.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = var.security_group_ids
    assign_public_ip = true
  }
}