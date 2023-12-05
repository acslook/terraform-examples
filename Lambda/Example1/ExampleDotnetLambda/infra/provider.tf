provider "aws" {
  region = var.REGION
}

terraform {
  backend "s3" {
    bucket = "acs-app-artifacts"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}