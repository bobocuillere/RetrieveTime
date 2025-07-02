############################################################
#  ECS Service alarms  (namespace: AWS/ECS)
############################################################
resource "aws_cloudwatch_metric_alarm" "ecs_cpu_high" {
  alarm_name          = "${var.project_name}-ECS-CPU-High"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2 # 10 min (metric period 300 s)
  datapoints_to_alarm = 2
  period              = 300
  statistic           = "Average"
  threshold           = var.ecs_cpu_high_threshold
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"

  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }

  treat_missing_data = "missing"
  tags               = var.tags
}

resource "aws_cloudwatch_metric_alarm" "ecs_mem_high" {
  alarm_name          = "${var.project_name}-ECS-Memory-High"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  datapoints_to_alarm = 2
  period              = 300
  statistic           = "Average"
  threshold           = var.ecs_memory_high_threshold
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"

  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }

  treat_missing_data = "missing"
  tags               = var.tags
}

############################################################
# ALB alarms  (namespace: AWS/ApplicationELB)
############################################################
resource "aws_cloudwatch_metric_alarm" "alb_5xx_high" {
  alarm_name          = "${var.project_name}-ALB-5xx"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1 # single 5-min interval
  period              = 300
  statistic           = "Sum"
  threshold           = var.alb_5xx_count_threshold
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"

  dimensions = {
    LoadBalancer = var.alb_full_name # arn suffix like app/my-alb/123…
  }

  treat_missing_data = "notBreaching"
  tags               = var.tags
}

resource "aws_cloudwatch_metric_alarm" "alb_latency_p95" {
  alarm_name          = "${var.project_name}-ALB-Latency-P95"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3 # 15 min rolling
  period              = 300
  extended_statistic  = "p95"
  threshold           = var.alb_p95_latency_threshold
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"

  dimensions = {
    LoadBalancer = var.alb_full_name
  }

  treat_missing_data = "notBreaching"
  tags               = var.tags
}

############################################################
#  CloudFront alarms  (namespace: AWS/CloudFront)
############################################################
resource "aws_cloudwatch_metric_alarm" "cf_5xx_rate" {
  alarm_name          = "${var.project_name}-CF-5xx-Rate"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 3 # 15 min
  period              = 300
  statistic           = "Average"
  threshold           = var.cf_5xx_rate_threshold
  metric_name         = "5xxErrorRate"
  namespace           = "AWS/CloudFront"

  dimensions = {
    DistributionId = var.cf_distribution_id
    Region         = "Global"
  }

  treat_missing_data = "notBreaching"
  tags               = var.tags
}
