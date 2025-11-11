resource "aws_ecs_task_definition" "this" {
  family                   = var.family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = "threat-composer"
      image     = var.image_url
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
     logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/app"
          awslogs-region        = var.region
          awslogs-stream-prefix = "app"
        }
      }
    }
  ])


}
