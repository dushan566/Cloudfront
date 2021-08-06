output "distribution_bucket_name" {
  value = aws_s3_bucket.s3.bucket
}

output "distribution_bucket_arn" {
  value = aws_s3_bucket.s3.arn
}