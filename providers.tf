terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}
terraform {
  backend "s3" {
    bucket         = "terraform-state-filebuckett"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}