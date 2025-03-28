provider "aws" {
  region = "us-east-1"
}

# Create Create an IAM policy and attach it to the user
# Create Create an  IAM policy and attach it to the user
resource "aws_iam_policy" "terraform_backend_policy_s3_only" {
  name        = "TerraformBackendS3Only-v2"
  description = "Permissions for Terraform to use S3 backend without locking"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::terraform-state-bucket",
          "arn:aws:s3:::terraform-state-bucket/*"
        ]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attach_backend_policy" {
  user       = "vchironi"
  policy_arn = aws_iam_policy.terraform_backend_policy_s3_only.arn
}
