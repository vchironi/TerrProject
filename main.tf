provider "aws" {
  region = "us-east-1"  # Adjust to your preferred region
}

# Create IAM Users
resource "aws_iam_user" "users" {
  for_each = toset(["ARMANDO", "Fucksas"])
  name     = each.key
}

# Define the IAM policy
resource "aws_iam_policy" "dynamodb_policy" {
  name        = "DynamoDBDescribeContinuousBackupsPolicy"
  description = "Policy to allow DescribeContinuousBackups on DynamoDB table"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "dynamodb:DescribeContinuousBackups",
        Resource = "arn:aws:dynamodb:us-east-1:651706766953:table/terraform-lock-mrim150c"
      }
    ]
  })
}







# Attach Read-Only EC2 Policy to Users
resource "aws_iam_user_policy_attachment" "readonly" {
  for_each   = aws_iam_user.users
  user       = each.key
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

# Create Access Keys for Users
resource "aws_iam_access_key" "keys" {
  for_each = aws_iam_user.users
  user     = each.key
}

# Optional: Output access keys (be careful with this in production)
output "user_access_keys" {
  value = {
    for k, v in aws_iam_access_key.keys : k => {
      access_key_id     = v.id
      secret_access_key = v.secret
    }
  }
  sensitive = true
}