resource "aws_s3_bucket" "terraform_state" {
    bucket = "project-terraform-up-and-running-state"

    lifecycle {
        prevent_destroy = false
    }
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
    name = "project-terraform-up-and-running-lock"
    hash_key = "LockID"
    read_capacity = 2
    write_capacity = 2
    
    attribute {
        name = "LockID"
        type = "S"
    }
}
