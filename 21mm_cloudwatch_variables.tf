


variable "region"{
    default = "use1"
}

variable "log_group_name" {
  default = "/ecs/ecstestask"                                                               
}
/*
variable "sns_topic"{
    default = "ops-tpca-stage-usxx-21mm-tf-proxy-alarms-topic"                                  
}                                                                                           

variable "sns_topic_subscription"{
    default = "email"
}

variable sns_topic_endpoint {
    default = "fidel.hernandez@toyota.com"                                                  
}
*/
variable "metric_namespace" {
  default = "ops-tpca-stage-use1-21mm-tf-proxy-log-group-metric-namespace"                      
}

variable "default_value"{
    default = "0"
}

variable "metric_transformation_unit" {
    default = "Count"
}

variable "metric_transformation_value" {
    default = "1"
}

variable "statistic"{
    default = "Sum"
}

variable "period"{
    default = "300"
}

variable "evaluation_periods"{
    default = "1"
}

variable "treat_missing_data" {
    default = "notBreaching"
}

