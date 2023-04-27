output "usernames" {
  value = { for i, j in aws_iam_user.allUsers : j.name => j.name }
}