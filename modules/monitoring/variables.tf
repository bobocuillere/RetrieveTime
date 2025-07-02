variable "project_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

# ---------- Thresholds (override only if you want different numbers) ----------
variable "ecs_cpu_high_threshold" {
  type    = number
  default = 80
}

variable "ecs_memory_high_threshold" {
  type    = number
  default = 80
}

variable "alb_5xx_count_threshold" {
  type    = number
  default = 5
}

variable "alb_p95_latency_threshold" {
  type    = number
  default = 1
}

variable "cf_5xx_rate_threshold" {
  type    = number
  default = 1
}

variable "ecs_cluster_name" {
  type = string
}

variable "ecs_service_name" {
  type = string
}

variable "alb_full_name" {
  type = string
}

variable "cf_distribution_id" {
  type = string
}
