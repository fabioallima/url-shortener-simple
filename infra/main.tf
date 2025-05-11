terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "url-shortener-terraform-state-dev"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock-dev"
    encrypt        = true
  }
}

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

# S3 Backend
# Definido em s3.tf
# - aws_s3_bucket.terraform_state
# - aws_s3_bucket_versioning.terraform_state
# - aws_s3_bucket_server_side_encryption_configuration.terraform_state
# - aws_s3_bucket_public_access_block.terraform_state
# - aws_dynamodb_table.terraform_state_lock

# Outputs
# Definidos em outputs.tf

# Variables
# Definidas em variables.tf

# Provider
# Definido em provider.tf
