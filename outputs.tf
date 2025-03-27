output "user_access_keys" {
  value = {
    for user, key in aws_iam_access_key.keys :
    user => {
      access_key_id     = key.id
      secret_access_key = key.secret
    }
  }

  sensitive = true
}