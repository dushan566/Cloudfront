#Usage

`
module "s3" {
  source = "../../terraform_modules/s3"
  s3_bucket_name           = "my-example-s3bucket.com"
  acl                      = var.acl
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
| s3\_bucket\_name | Name of the S3 bucket | `string` | n/a | yes |
| acl | S3 access mode. Indicates where public or private S3 | `string` | n/a | yes |
| tags | A set of AWS tags | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_name |s3 bucket name |
