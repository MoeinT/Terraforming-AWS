output "groupname" {
  value = { for i, j in aws_iam_group.AllGroups : j.name => j.name }
}