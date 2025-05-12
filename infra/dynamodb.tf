resource "aws_dynamodb_table" "url_shortener" {
  name         = "url-shortener-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  lifecycle {
    ignore_changes = [name]
  }

  tags = {
    Name        = "url-shortener-table"
    Environment = "dev"
    Project     = "url-shortener"
  }
}

# Tabela DynamoDB para bloqueio de estado
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-state-lock-${var.environment}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform State Lock"
    Environment = var.environment
  }

    lifecycle {
    ignore_changes = [name]
  }
}