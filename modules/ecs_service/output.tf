output "ecs_service_arn" {
  description = "The ARN of the ECS service"
  value       = aws_ecs_service.this.id
}