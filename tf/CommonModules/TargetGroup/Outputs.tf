output "TargetGroup_ids" {
  value = { for i, j in aws_lb_target_group.AllTargetGroups : j.tags_all.Name => j.id }
}

output "TargetGroup_arns" {
  value = { for i, j in aws_lb_target_group.AllTargetGroups : j.tags_all.Name => j.arn }
}