resource "aws_lambda_function" "create_url_shortener" {
  function_name = "create-url-shortener"
  runtime       = "python3.11"
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.lambda_exec_role.arn
  timeout       = 10

  filename         = var.lambda_zip_path
  source_code_hash = filebase64sha256(var.lambda_zip_path)

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.url_shortener.name
    }
  }

  lifecycle {
    ignore_changes = [function_name]
  }
}
