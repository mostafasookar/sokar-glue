variable "region" {
  description = "AWS region (UAT)"
  type        = string
  default     = "us-east-1"
}

variable "account_id" {
  description = "AWS Account ID (UAT sandbox)"
  type        = string
  default     = "286452157068"
}

variable "scripts_bucket" {
  description = "S3 bucket for Glue job scripts (UAT)"
  type        = string
  default     = "glue-sokar-test"
}
