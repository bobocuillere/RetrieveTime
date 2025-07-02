output "repository_url" {
  value       = aws_ecr_repository.this.repository_url
  description = "URI you push Docker images to"
}

output "repository_name" {
  value = aws_ecr_repository.this.name
}
