###############################################
# Random suffix for globally unique bucket name
###############################################
resource "random_id" "suffix" {
  byte_length = 4
}

###############################################
# S3 bucket – static React site
###############################################
resource "aws_s3_bucket" "this" {
  bucket        = "${var.project_name}-static-${random_id.suffix.hex}"
  force_destroy = true

  tags = merge(var.tags, { Name = "${var.project_name}-static" })
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

###############################################
# Origin Access Control
# Bucket policy will be added in CloudFront module.
###############################################
resource "aws_cloudfront_origin_access_control" "this" {
  name                              = "${var.project_name}-oac"
  description                       = "OAC for S3 static site"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
  origin_access_control_origin_type = "s3"
}

###############################################
# Upload static files automatically
###############################################
locals {
  frontend_files = fileset(var.frontend_path, "**") # all files under build dir
}

resource "aws_s3_object" "site_files" {
  for_each = { for f in local.frontend_files : f => f }

  bucket = aws_s3_bucket.this.id
  key    = each.key
  source = "${var.frontend_path}/${each.value}"
  etag   = filemd5("${var.frontend_path}/${each.value}")

  content_type = lookup(
    var.mime_types,
    regex("[^.]+$", each.key),
    "binary/octet-stream"
  )

  cache_control = (
    each.key == "index.html"
    ? "max-age=0,no-cache,no-store,must-revalidate"
    : "public,max-age=31536000,immutable"
  )

  tags = merge(var.tags, { File = each.key })
}
