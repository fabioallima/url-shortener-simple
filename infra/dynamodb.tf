resource "aws_dynamodb_table" "url_shortener" {
  name         = "url-shortener-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
