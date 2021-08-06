output "lambda_function_arn" {
  value = aws_lambda_function.lambda.arn
  description = "ARN of the Lambda"
}

output "lambda_function_name" {
  value = aws_lambda_function.lambda.function_name
  description = "Function name of the Lambda"
}