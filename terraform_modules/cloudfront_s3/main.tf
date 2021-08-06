################ Create Log Log S3 ####################
resource "aws_s3_bucket" "log_bucket" {
  bucket        = lower("${var.application}-${var.subsystem}-${var.environment}-cloudfront-logs")
  force_destroy = true

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = var.tags
}
##############################################################################

################ Create CloudFront origin Request policy ####################
resource "aws_cloudfront_origin_request_policy" "origin_request_policy" {
  name    = lower("${var.application}-${var.subsystem}-${var.environment}-origin-request-policy")
  comment = title("${var.application}-${var.subsystem}-${var.environment}-origin-request-policy to Whitelist headers")
  cookies_config {
    cookie_behavior = "none"
#    cookies {
#      items = [""]
#    }
  }
  headers_config {
    header_behavior = "whitelist"
    headers {
      items = ["Cache-Control",
      "Access-Control-Allow-Origin",
      "Access-Control-Request-Headers",
      "Access-Control-Allow-Credentials",
      "Access-Control-Allow-Methods",
      "Access-Control-Request-Method",
      "Access-Control-Max-Age",
      "Origin"
      ]
    }
  }
  query_strings_config {
    query_string_behavior = "none"
#    query_strings {
#      items = [""]
#    }
  }
}
##############################################################################

################ Create CloudFront Caching Disabled Policy ####################
resource "aws_cloudfront_cache_policy" "cache_disabled_policy" {
  name        = lower("${var.application}-${var.subsystem}-${var.environment}-CachingDisabled")
  comment     = title("${var.application} ${var.subsystem} ${var.environment} Policy with caching disabled")
  default_ttl = 0
  max_ttl     = 0
  min_ttl     = 0
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}
##############################################################################


################ Create CloudFront Cache enabled Policy ####################
resource "aws_cloudfront_cache_policy" "cache_policy" {
  name        = lower("${var.application}-${var.subsystem}-${var.environment}-cache-policy")
  comment     = title("${var.application} ${var.subsystem} ${var.environment}  cache enabled policy")
  min_ttl                = var.min_ttl
  default_ttl            = var.default_ttl
  max_ttl                = var.max_ttl
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
    # ----------------- Content compression ------------------------#
    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip = true

    ## CloudFront by default compress Content in Edge servers. If the above two options are true,
    ## content compression is supported for HTTP2 request. Then CloudFront compresses files that
    ## have the matching Content-Type header mentioned on https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/ServingCompressedFiles.html
  }
}
##############################################################################


################ Create CloudFront origin access identity ####################
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = lower("${var.application}-${var.subsystem}-${var.environment}-origin-access-identity")
}

################ Create CloudFront Distribution ####################
resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name = "${var.origin_domain_name}.s3.amazonaws.com"
    origin_id   = "S3-${var.s3_origin_id}"
    origin_path = var.origin_path

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = ""
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.log_bucket.bucket_domain_name
    prefix          = "CloudFront_Logs"
  }

  aliases = var.aliases

  # Default Cache behavior (Cache all files)
  #-----------------------------------------
  default_cache_behavior {
   #allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"] # you can use this based on your business requirment
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "S3-${var.s3_origin_id}"
    origin_request_policy_id = aws_cloudfront_origin_request_policy.origin_request_policy.id
    cache_policy_id = aws_cloudfront_cache_policy.cache_policy.id
    smooth_streaming = false

    lambda_function_association {
     event_type   = "viewer-request"
     lambda_arn   = var.edge_lambda_function_arn
     include_body = false
    }


    viewer_protocol_policy = "allow-all"
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
  }



  # Cache behavior with precedence 0 (Disable cache for JSON)
  #----------------------------------------------------------
  ordered_cache_behavior {
    path_pattern     = "/*.json"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.s3_origin_id}"
    origin_request_policy_id = aws_cloudfront_origin_request_policy.origin_request_policy.id
    cache_policy_id = aws_cloudfront_cache_policy.cache_disabled_policy.id

    lambda_function_association {
     event_type   = "viewer-request"
     lambda_arn   = var.edge_lambda_function_arn
     include_body = false
    }

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "allow-all"
  }

  # Cache behavior with precedence 1 (Disable cache for JS)
  #--------------------------------------------------------
  ordered_cache_behavior {
    path_pattern     = "/*.js"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.s3_origin_id}"
    origin_request_policy_id = aws_cloudfront_origin_request_policy.origin_request_policy.id
    cache_policy_id = aws_cloudfront_cache_policy.cache_disabled_policy.id

    lambda_function_association {
     event_type   = "viewer-request"
     lambda_arn   = var.edge_lambda_function_arn
     include_body = false
    }

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "allow-all"
  }

  # Cache behavior with precedence 2 (Disable cache for CSS)
  #----------------------------------------------------------
  ordered_cache_behavior {
    path_pattern     = "/*.css"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.s3_origin_id}"
    origin_request_policy_id = aws_cloudfront_origin_request_policy.origin_request_policy.id
    cache_policy_id = aws_cloudfront_cache_policy.cache_disabled_policy.id

    lambda_function_association {
     event_type   = "viewer-request"
     lambda_arn   = var.edge_lambda_function_arn
     include_body = false
    }

    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
    viewer_protocol_policy = "allow-all"
  }

#-----------------------------------------
  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
     restriction_type = "none"
    }
  }

  tags = var.tags

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}
##############################################################################

# Allow cloudfront to Origin S3 bucket
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${var.distribution_bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = var.distribution_bucket_id
  policy = data.aws_iam_policy_document.s3_policy.json
}