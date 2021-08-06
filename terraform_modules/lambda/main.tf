module "lambda_service_role" {
  source = "../../terraform_modules/iam_role"
  application = var.application
  subsystem = var.subsystem
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_for_lambda.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/CloudFrontReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchFullAccess"
  ]
  tags = var.tags
}

resource "aws_cloudwatch_log_group" "lambda_loggroup" {
  name              = "/aws/lambda/${var.application}-${var.environment}-${var.lambda_task_name}-logs"
  retention_in_days = 14
  tags = var.tags
}

resource "aws_lambda_function" "lambda" {
  function_name = lower("${var.application}-${var.environment}-${var.lambda_task_name}-function")
  description = var.description
  role = module.lambda_service_role.iam_role_arn
  #lambda_at_edge = true
  filename = var.filename
  source_code_hash = var.source_code_hash
  handler = var.handler
  runtime = var.runtime
  publish = "true"
  #version = "1"
  tags = var.tags

  depends_on = [
    aws_cloudwatch_log_group.lambda_loggroup
  ]

}