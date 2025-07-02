variable "project_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "s3_bucket_domain_name" {
  type = string
}

variable "s3_bucket_id" {
  type = string
}

variable "s3_bucket_arn" {
  type = string
}

variable "oac_id" {
  type = string
}

variable "alb_dns_name" {
  type = string
}
