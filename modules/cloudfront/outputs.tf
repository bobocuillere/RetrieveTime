output "distribution_domain" {
  value       = aws_cloudfront_distribution.this.domain_name
  description = "URL of the CloudFront distribution"
}

output "distribution_id" {
  value = aws_cloudfront_distribution.this.id
}
