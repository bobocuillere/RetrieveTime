variable "project_name" {
  type        = string
  description = "The name of the project."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to resources."
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where resources will be deployed."
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "A list of IDs for the public subnets."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "A list of IDs for the private subnets."
}
