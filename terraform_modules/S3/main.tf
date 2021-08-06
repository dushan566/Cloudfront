resource "aws_s3_bucket" "s3" {

  bucket = var.s3_bucket_name
  acl = var.acl
  policy = var.policy

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = var.tags
}
