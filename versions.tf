terraform {
    required_version = " >= 0.13.6"
    required_providers{
        aws = {
            source = "hashicorp/aws"
            version = "4.34.0"
        }
    }
        backend "s3"{
        bucket = "21mm-pre-prod-tfstate-s3-bucket"
        key = "LockID"
        dynamodb_table = "21mm-pre-prod-tfstate-lock-dynamo"
        region = "us-east-1"
    }
}

