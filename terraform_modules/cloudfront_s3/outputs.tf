output "distribution_id" {
  value = aws_cloudfront_distribution.distribution.id
  description = "CloudFront distribution id"
}

output "distribution_arn" {
  value = aws_cloudfront_distribution.distribution.arn
  description = "CloudFront distribution arn"
}


output "log_bucket_name" {
  value = aws_s3_bucket.log_bucket.bucket_domain_name
  description = "CloudFront Log bucket name"
}

output "origin_access_identity_path" {
  value = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
  description = "CloudFront Origin Identity Access path"
}

output "aws_cloudfront_origin_request_policy" {
  value = aws_cloudfront_origin_request_policy.origin_request_policy.name
  description = "CloudFront Origin Identity Request policy"
}

output "aws_cloudfront_origin_cache_policy" {
  value = aws_cloudfront_cache_policy.cache_policy.name
  description = "CloudFront Origin Content Cache policy"
}
