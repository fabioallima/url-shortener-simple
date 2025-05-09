output "lambda_function_name" {
  value = aws_lambda_function.create_url_shortener.function_name
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.url_shortener.name
}
