output "ecs_task_definition_arn" {
  description = "ARN of Prometheus ECS task"
  value       = aws_ecs_task_definition.prometheus.arn
}

output "ecs_service_name" {
  description = "Prometheus ECS service name"
  value       = aws_ecs_service.prometheus.name
}
