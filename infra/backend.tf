terraform {
  backend "s3" {
    bucket         = "alismed-terraform"
    key            = "api-ec2/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}