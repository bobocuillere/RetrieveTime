variable "project_name" {
  description = "Project identifier, used in repository name"
  type        = string
}

variable "tags" {
  description = "Common tags to apply"
  type        = map(string)
}
