provider "aws" {
  region = var.region
  profile = "AdminRole"
}


# Own state.
#############################################################################################
terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket"
    key = "terraform-state-files/environment/category-name.terraform.tfstate"
    region = "eu-west-1"
    profile = "AdminRole"
    dynamodb_table = "terraform-state-lock"
  }
}

# ------------------------------------------------------------------------------------- #
module "s3" {
  source = "../../../terraform_modules/s3"
  s3_bucket_name           = "my.example.com"
  acl                      = var.acl
  tags                     = var.tags
}
# ------------------------------------------------------------------------------------- #

# ------------------------------------------------------------------------------------- #
module "lambda_edge_rule" {
  source = "../../../terraform_modules/lambda"
  application = var.application
  description = "URL rewrite rule for additionl slashes"
  environment = var.environment
  lambda_task_name = "cloudfront-double-slash-rewrite"
  runtime = "nodejs14.x"
  handler = "index.handler"
  source_code_hash = filebase64sha256("lambda_at_edge_redirect_double_slashes_payload.zip")
  filename = "lambda_at_edge_redirect_double_slashes_payload.zip"
  distribution_arn         = module.cloudfront.distribution_arn
  tags = var.tags
}
# ------------------------------------------------------------------------------------- #



# ------------------------------------------------------------------------------------- #

module "cloudfront" {
  source = "../../../terraform_modules/cloudfront_s3"
  application              = var.application
  environment              = var.environment
  subsystem                = var.subsystem
  acm_certificate_arn      = var.acm_certificate_arn
  s3_origin_id             = module.s3.distribution_bucket_name
  edge_lambda_function_arn = "${module.lambda_edge_rule.lambda_function_arn}:1"
  origin_path              = var.origin_path
  origin_domain_name       = module.s3.distribution_bucket_name
  distribution_bucket_id   = module.s3.distribution_bucket_name
  distribution_bucket_arn  = module.s3.distribution_bucket_arn
  aliases                  = ["my.example.com"]
  tags                     = var.tags
}

# ------------------------------------------------------------------------------------- #


# add permission to lambda
resource "aws_lambda_permission" "allow_getFunction" {
  action = "lambda:GetFunction"
  function_name = module.lambda_edge_rule.lambda_function_name
  principal = "replicator.lambda.amazonaws.com"
  source_arn = module.cloudfront.distribution_arn
}