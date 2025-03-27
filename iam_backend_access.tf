resource "aws_iam_policy" "terraform_backend_policy" {
  name        = "TerraformBackendAccess"
  description = "Permissions to access S3 and DynamoDB for Terraform backend with locking"

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
      },
      {
        Effect = "Allow",
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:DescribeTable",
          "dynamodb:DescribeContinuousBackups"
        ],
        Resource = "arn:aws:dynamodb:us-east-1:651706766953:table/terraform-lock-*"
      }
    ]
  })
}