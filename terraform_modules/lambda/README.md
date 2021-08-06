# Usage

`
module "lambda_edge_rule" {
  source = "../../terraform_modules/lambda"
  application = var.application
  description = "A short description of your function"
  environment = var.environment
  lambda_task_name = "cloudfront-double-slash-rewrite"
  runtime = "nodejs14.x"
  handler = "index.handler"
  source_code_hash = filebase64sha256("lambda_at_edge_redirect_double_slashes_payload.zip")
  filename = "lambda_at_edge_redirect_double_slashes_payload.zip"
  distribution_arn         = module.cloudfront.distribution_arn
  tags = var.tags
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
| description | Description of your Lambda function | `string` | n/a | yes |
| environment | Environment to which the parameter belongs | `string` | n/a | yes |
| lambda_task_name | short name of your Lambda function without space | `string` | n/a | yes |
| runtime | The running envrionment of the lambda | `string` | n/a | yes |
| handler | The handler of the lambda | `string` | n/a | yes |
| source\_code\_hash | The source code sha used for the package specified in filename | `string` | n/a | yes |
| filename | The script for the lambda | `string` | n/a | yes |
| distribution\_arn | ARN of Cloudfront distribution | `string` | n/a | yes |
| tags | AWS tags | `map` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| lambda\_function\_arn | ARN of the Lambda |
| lambda\_function\_name | Function name of the Lambda |