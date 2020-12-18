// rola
resource "aws_iam_role" "lambda" {
  name               = "lambda-${var.name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
      ]
    }
  }
}

// polityka
resource "aws_iam_role_policy" "lambda" {
  role   = aws_iam_role.lambda.name
  policy = var.policy

}

// kod lambdy
data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = "/tmp/lambdas/${var.name}.zip"
}

// lambda
resource "aws_lambda_function" "lambda" {
  function_name    = var.name
  handler          = var.handler
  runtime          = var.runtime
  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256
  role             = aws_iam_role.lambda.arn
}
