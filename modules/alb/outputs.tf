output "alb_dns_name" {
  value       = aws_lb.this.dns_name
  description = "Public DNS name of the ALB"
}

output "alb_sg_id" {
  value = aws_security_group.alb.id
}

output "ecs_task_sg_id" {
  value = aws_security_group.ecs_tasks.id
}

output "target_group_arn" {
  value = aws_lb_target_group.ecs.arn
}

output "alb_full_name" {
  value = aws_lb.this.arn_suffix
}
