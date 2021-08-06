# Assume Rple Policies.
data "aws_iam_policy_document" "assume_role_policy_for_lambda" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
        "edgelambda.amazonaws.com",
        "s3.amazonaws.com"
      ]
    }
  }
}