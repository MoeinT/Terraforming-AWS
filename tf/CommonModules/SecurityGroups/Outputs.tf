output "SecurityGroup_ids" {
  value = { for i, j in aws_security_group.allSecurityGroups : j.tags_all.Name => j.id }
}