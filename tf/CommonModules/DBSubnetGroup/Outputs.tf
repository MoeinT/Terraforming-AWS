output "DBSubnetGroup_ids" {
  value = { for i, j in aws_db_subnet_group.DBSubnetGroups : j.tags_all.Name => j.id }
}

output "DBSubnetGroup_names" {
  value = { for i, j in aws_db_subnet_group.DBSubnetGroups : j.tags_all.Name => j.tags_all.Name }
}