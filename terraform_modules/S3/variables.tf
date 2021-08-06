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
  type = map(string)
  description = "A set of AWS tags"
}
