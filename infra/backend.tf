terraform {
  backend "s3" {
    bucket         = "url-shortener-terraform-state-dev"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock-dev"
    encrypt        = true
  }
} 