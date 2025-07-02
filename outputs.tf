output "repository_url" {
  value       = module.ecr.repository_url
  description = "URI you push Docker images to"
}

output "app_url" {
  value       = module.cloudfront.distribution_domain
  description = "Public entry point"
}

output "bucket_id" {
  value       = module.s3_static_site.bucket_id
  description = "S3 bucket ID for static site"

}