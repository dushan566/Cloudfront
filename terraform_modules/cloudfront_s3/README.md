# Usage

`
module "cloudfront_s3" {
  source = "../../terraform_modules/cloudfront_s3"
  application              = var.application
  environment              = var.environment
  subsystem                = var.subsystem
  acm_certificate_arn      = var.acm_certificate_arn
  s3_origin_id             = var.s3_origin_id
  edge_lambda_function_arn = var.edge_lambda_function_arn
  origin_path              = var.origin_path
  origin_domain_name       = module.s3.distribution_bucket_name
  distribution_bucket_id   = module.s3.distribution_bucket_name
  distribution_bucket_arn  = module.s3.distribution_bucket_arn
  aliases                  = ["subdomain1.example.com","subdomain2.example.com", "subdomain3.example.com"]
  tags                     = var.tags
}
`

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application | Name of the application | `string` | n/a | yes |
| environment | Environment to which the resources belong | `string` | n/a | yes |
| subsystem | subsystem of your application. Indicates where the subsystem is used | `string` | n/a | yes |
| acm\_certificate\_arn | SAN certificate of your application | `string` | n/a | yes |
| s3\_origin\_id | This will be your Origin S3 bucket name | `string` | n/a | yes |
| edge\_lambda\_function\_arn | Lambda@edge custom rule for URL rewrite | `string` | n/a | yes |
| origin\_path | Required if you your application hosted in custom folder | `string` | n/a | no |
| origin\_domain\_name | This will be your Origin domain which should match to S3 bucket name | `string` | n/a | yes |
| distribution\_bucket\_id | Cloudfront S3 ID required for S3 bucket policy | `string` | n/a | yes |
| distribution_bucket_arn | Cloudfront S3 ARN required for S3 bucket policy | `string` | n/a | yes |
| aliases | List of subdomains Required to match in the Cloudfront destribution | `list(string)` | `[]` | yes |
| tags | A set of AWS tags | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| distribution\_id | Cloudfront distribution id |
| distribution\_arn | CloudFront distribution arn |
| log\_bucket\_name | Cloudfront log bucket name |
| origin\_access\_identity\_path | CloudFront Origin Identity Access path |
| aws\_cloudfront\_origin\_request\_policy | Custom Origin Request policy |
| aws\_cloudfront\_origin\_cache\_policy |  Custom Origin Cache Policy |