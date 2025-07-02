variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "project_name" {
  description = "Project identifier to include in names"
  type        = string
}

variable "tags" {
  description = "Map of common tags to apply to all resources"
  type        = map(string)
}
