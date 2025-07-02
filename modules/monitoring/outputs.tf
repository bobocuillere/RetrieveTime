output "alarm_names" {
  value = [
    aws_cloudwatch_metric_alarm.ecs_cpu_high.alarm_name,
    aws_cloudwatch_metric_alarm.ecs_mem_high.alarm_name,
    aws_cloudwatch_metric_alarm.alb_5xx_high.alarm_name,
    aws_cloudwatch_metric_alarm.alb_latency_p95.alarm_name,
    aws_cloudwatch_metric_alarm.cf_5xx_rate.alarm_name
  ]
  description = "CloudWatch alarm names you can attach actions to later."
}
