# S3 bucket para armazenar o estado do Terraform
# resource "aws_s3_bucket" "terraform_state" {
#   bucket = "url-shortener-terraform-state-${var.environment}"

#   lifecycle {
#     prevent_destroy = true
#   }

#   tags = {
#     Name        = "Terraform State"
#     Environment = var.environment
#   }
# }

# # Habilitar versionamento para os arquivos de estado
# resource "aws_s3_bucket_versioning" "terraform_state" {
#   bucket = aws_s3_bucket.terraform_state.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# # Habilitar criptografia server-side por padrão
# resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
#   bucket = aws_s3_bucket.terraform_state.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# # Bloqueio de acesso público
# resource "aws_s3_bucket_public_access_block" "terraform_state" {
#   bucket = aws_s3_bucket.terraform_state.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# Os recursos do backend (S3 bucket e DynamoDB table) já foram criados manualmente
# e estão sendo referenciados na configuração do backend em backend.tf

