
terraform {
  backend "s3" {
    bucket         = "terraform-state-filebuckett"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}