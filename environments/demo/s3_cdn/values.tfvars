application              = "myapp"
environment              = "demo"
subsystem                = "customerx"
acm_certificate_arn      = "arn:aws:acm:us-east-1:xxxxxxxxxxxxx:certificate/xxxxxxxxxxxxxx"

# Custom S3 Sub folder name/path if your application hosted in a different folder inside S3 root directory (/).
# Eg/- "myfolder1/application_contents"
origin_path              = ""

# AWS region where the resource whould provision
region                   = "us-east-1"

# Cloudfront cache TTL values
min_ttl                  = "60"
default_ttl              = "86400"
max_ttl                  = "2628000"

# List of domains should serve though Cloudfront. Note: same domains should available in SAN certificate.

# List of AWS Tags
tags = {
  environment = "DEMO"
  dcl = "1"
  owner = "support1@example.com"
  role  = "App"
  terraform = "Yes"
}
