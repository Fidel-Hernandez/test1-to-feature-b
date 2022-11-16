

resource "aws_sns_topic" "ops-tpca-stage-21mm-tf-proxy-alarms-topic" {
  name         = "ops-tpca-stage-${var.region}-21mm-tf-proxy-alarms-topic"                                                                                      
  display_name = "ops-tpca-stage-${var.region}-21mm-tf-proxy-alarms-topic"
}
 
resource "aws_sns_topic_subscription" "ops-team-email" {
  topic_arn = aws_sns_topic.ops-tpca-stage-21mm-tf-proxy-alarms-topic.arn
  protocol  = "email"
  endpoint  = "fidel.hernandez@toyota.com"
}


resource "aws_cloudwatch_log_metric_filter" "ops-tpca-stage-21mm-tf-proxy-login-failed" {
  log_group_name = var.log_group_name
  name           = "ops-tpca-stage-${var.region}-21mm-tf-proxy-login-failed"                                                       
  pattern        = "[date, timestamp, requestId, messageType= Error, codeinfo, latency, httpType, message= \"*/login failed*\"]"        
  
  metric_transformation {
    namespace     = var.metric_namespace
    name          = "ops-tpca-prod-${var.region}-21mm-proxy-login-failed-metric"                                                 
    value         = var.metric_transformation_value
    default_value = var.default_value
    unit          = var.metric_transformation_unit
  }
}

resource "aws_cloudwatch_metric_alarm" "ops-tpca-stage-21mm-tf-proxy-login-failed" {
  alarm_name          = "ops-tpca-prod-${var.region}-21mm-proxy-login-failed"
  alarm_description   = "21MM Proxy Alarm that is triggered by the words xx found in the log stream."
  namespace           = var.metric_namespace
  metric_name         = "ops-tpca-prod-${var.region}-21mm-proxy-login-failed-metric"                                             
  statistic           = var.statistic
  period              = var.period
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = "1"
  evaluation_periods  = var.evaluation_periods
  alarm_actions       = [aws_sns_topic.ops-tpca-stage-21mm-tf-proxy-alarms-topic.arn]
  treat_missing_data  = var.treat_missing_data
}


