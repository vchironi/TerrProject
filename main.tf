provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "users" {
  for_each = toset(var.usernames)
  name     = each.value
}

resource "aws_iam_user_policy_attachment" "readonly" {
  for_each       = toset(var.usernames)
  user           = each.value
  policy_arn     = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_access_key" "keys" {
  for_each = toset(var.usernames)
  user     = each.value
}