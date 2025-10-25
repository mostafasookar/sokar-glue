variable "region" {
  description = "AWS region (PROD)"
  type        = string
  default     = "me-central-1"
}

variable "account_id" {
  description = "AWS Account ID (PROD sandbox)"
  type        = string
  default     = "286452157068"
}

variable "scripts_bucket" {
  description = "S3 bucket for Glue job scripts (PROD)"
  type        = string
  default     = "glue-sokar-uae"
}
