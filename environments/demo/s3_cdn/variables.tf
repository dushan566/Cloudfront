variable "application" {
  type = string
  default = "myapp"
  description = "Name of the application"
}

variable "region" {
  type = string
  default = "us-east-1"
  description = "Hosting region"
}

variable "environment" {
  type = string
  default = "demo"
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


variable "origin_path" {
  description = "(Required) - custom origin path (sub folder in S3)"
  default     = ""
}


variable "acm_certificate_arn" {
  type = string
  description = "ACM Certificate ARN"
}


variable "s3_bucket_name" {
  type = string
  default = "yourdomainname.com"
  description = "Name of your S3 bucket"
}

variable "acl" {
  type = string
  default = "private"
  description = "Access type of your S3 bucket"
}

variable "policy" {
  type = string
  default = ""
  description = "S3 bucket policy"
}

variable "tags" {
  type = map
  default = {}
  description = "Tags that will be assigned to the resource"
}