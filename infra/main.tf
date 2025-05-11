provider "aws" {
  region = var.aws_region
}


# DynamoDB
# Definido em dynamodb.tf
# - aws_dynamodb_table.url_shortener

# IAM
# Definido em iam.tf
# - aws_iam_role.lambda_exec_role
# - aws_iam_role_policy_attachment.lambda_dynamodb_attach
# - aws_iam_role_policy_attachment.lambda_basic_exec

# Lambda
# Definido em lambda.tf
# - aws_lambda_function.create_url_shortener

# API Gateway (reservado para uso futuro)
# - apigateway.tf

# Outputs
# Definidos em outputs.tf

# Variables
# Definidas em variables.tf

# Provider
# Definido em provider.tf
