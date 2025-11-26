output "ecs_task_definition_arn" {
  description = "ARN of Grafana ECS task"
  value       = aws_ecs_task_definition.grafana.arn
}

output "ecs_service_name" {
  description = "Grafana ECS service name"
  value       = aws_ecs_service.grafana.name
}

