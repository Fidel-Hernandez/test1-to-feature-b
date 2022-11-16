

locals {
  resource_prefix = "${var.project_name}-${var.environment}"
}

#Create S3 bucket to store tfstate files
resource "aws_s3_bucket" "tfstate-s3-bucket" {
  bucket = "${local.resource_prefix}-tfstate-s3-bucket"
  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
         sse_algorithm = "AES256"
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }

 # tags = var.tags
}

# create a dynamodb table for locking the state file
resource "aws_dynamodb_table" "tfstate-lock-dynamodb" {
  name         = "${local.resource_prefix}-tfstate-lock-dynamo"
  billing_mode = "PAY_PER_REQUEST" # Created a ddb with no capacity planning, pricing tier = pay per request
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }
  #tags = var.tags
}

# Block all public access to S3
resource "aws_s3_bucket_public_access_block" "s3_public_access_block" {
  bucket = aws_s3_bucket.tfstate-s3-bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

