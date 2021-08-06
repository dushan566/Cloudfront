variable "application" {
  type = string
  default = "demo"
  description = "Name of the application"
}

variable "environment" {
  type = string
  default = "dev"
  description = "Environment to which the infrastructure belongs."
}

variable "subsystem" {
  type = string
  default = "customer1"
  description = "Custommer name or subsystem name."
}

variable "min_ttl" {
  type = string
  default = "86400"
  description = "Minimum cache TTL. Default set to 1 day"
}

variable "default_ttl" {
  type = string
  default = "86400"
  description = "Minimum cache TTL. Default set to 1 day"
}

variable "max_ttl" {
  type = string
  default = "86400"
  description = "Minimum cache TTL. Default set to 1 day"
}

variable "aliases" {
  type        = list(string)
  default     = []
  description = "List of aliases. CAUTION! Names MUSTN'T contain trailing `.`"
}

variable "origin_domain_name" {
  description = "(Required) - The DNS domain name of your custom origin (e.g. website)"
  default     = ""
}

variable "origin_path" {
  description = "(Required) - custom origin path (sub folder in S3)"
  default     = ""
}

variable "s3_origin_id" {
  description = "(Required) - The origin id (e.g. S3-<bucket name>)"
  default     = ""
}

variable "path_pattern" {
  description = "S3 resource path "
  default     = ""
}

variable "acm_certificate_arn" {
  type = string
  description = "ACM Certificate ARN"
}

variable "edge_lambda_function_arn" {
  type = string
  description = "Lambda @Edge rule ARN"
}

variable "distribution_bucket_id" {
  type = string
  description = "Cloudfront S3 ID"
}

variable "distribution_bucket_arn" {
  type = string
  description = "Cloudfront S3 ARN"
}

variable "tags" {
  type = map
  default = {}
  description = "Tags that will be assigned to the resource"
}