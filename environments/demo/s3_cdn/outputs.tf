output "distribution_bucket_name" {
  value       = module.s3.distribution_bucket_name
  description = "Name of CloudFront distribution S3 bucket"
}

output "distribution_bucket_arn" {
  value       = module.s3.distribution_bucket_arn
  description = "ARN of CloudFront distribution S3 bucket"
}

output "lambda_function_arn" {
  value = module.lambda_edge_rule.lambda_function_arn
  description = "ARN of the Lambda"
}

output "lambda_function_name" {
  value = module.lambda_edge_rule.lambda_function_name
  description = "Function name of the Lambda"
}

output "distribution_id" {
  value       = module.cloudfront.distribution_id
  description = "ID of CloudFront distribution"
}

output "distribution_arn" {
  value = module.cloudfront.distribution_arn
  description = "CloudFront distribution arn"
}


output "log_bucket_name" {
  value       = module.cloudfront.log_bucket_name
  description = "CloudFront Log bucket name"
}

output "origin_access_identity_path" {
  value       = module.cloudfront.origin_access_identity_path
  description = "CloudFront Origin Identity Access path"
}

output "aws_cloudfront_origin_request_policy" {
  value       = module.cloudfront.aws_cloudfront_origin_request_policy
  description = "CloudFront Origin Identity Request policy"
}

output "aws_cloudfront_origin_cache_policy" {
  value = module.cloudfront.aws_cloudfront_origin_cache_policy
  description = "CloudFront Origin Identity Request policy"
}
