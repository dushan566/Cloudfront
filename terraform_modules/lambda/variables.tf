variable "application" {
  type = string
  description = "Name of the application"
}

variable "subsystem" {
  type = string
  default = "customer1"
  description = "Custommer name or subsystem name."
}

variable "environment" {
  type = string
  description = "Environment to which the parameter belongs"
}


variable "distribution_arn" {
  type = string
  description = "Cloudfront distribution ARN"
}

variable "lambda_task_name" {
  type = string
  description = "Indicates the purpose of the lamda function"
}


variable "description" {
  type = string
  description = "description of the lamda function"
}

variable "runtime" {
  type = string
  description = "The running envrionment of the lambda"
}

variable "filename" {
  type = string
  description = "The script for the lambda"
}

variable "handler" {
  type = string
  description = "The handler of the lambda"
}

variable "source_code_hash" {
  type = string
  description = "The source code sha used for the package specified in filename"
}

variable "tags" {
  type = map
  description = "AWS tags"
}