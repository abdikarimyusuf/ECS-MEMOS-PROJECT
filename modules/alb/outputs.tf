output "alb_dns" {
  value = aws_lb.this.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.this.arn
}

output "alb_zone_id" {
  value = aws_lb.this.zone_id   # needed for Route53
}

output "alb_arn" {

  value = aws_lb_listener.https.arn
  
}