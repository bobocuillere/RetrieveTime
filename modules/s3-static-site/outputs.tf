output "bucket_id" {
  value       = aws_s3_bucket.this.id
  description = "Static-site bucket name"
}

output "bucket_domain_name" {
  value       = aws_s3_bucket.this.bucket_regional_domain_name
  description = "Regional endpoint for the bucket"
}

output "bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = "ARN of the bucket"
}

output "oac_id" {
  value       = aws_cloudfront_origin_access_control.this.id
  description = "ID of the S3 OAC"
}
