variable "project_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "task_sg_id" {
  type = string

}

variable "target_group_arn" {
  type = string

}

variable "ecr_repository_url" {
  type = string

}

variable "desired_count" {
  type    = number
  default = 2
}
