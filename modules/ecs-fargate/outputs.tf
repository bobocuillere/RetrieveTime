output "service_name" {
  value = aws_ecs_service.api.name
}

output "cluster_id" {
  value = aws_ecs_cluster.this.id
}
