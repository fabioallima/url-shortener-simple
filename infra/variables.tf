variable "aws_region" {
  default = "us-east-1"
}

variable "lambda_zip_path" {
  default = "lambdas/create_url/lambda_create_url.zip"
}

variable "environment" {
  description = "Ambiente de deploy (dev, staging, prod)"
  type        = string
  default     = "dev"
}
