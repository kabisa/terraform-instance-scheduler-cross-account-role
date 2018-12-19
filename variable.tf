variable "aws_master_account_id" {
  description = "AWS account id where the instance scheduler is running"
}

variable "enable_instance_scheduler_cross_account_role" {
  description = "enable if role has to be created"
  default = true
}
