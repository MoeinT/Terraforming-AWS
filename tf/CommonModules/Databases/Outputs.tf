output "db_endpoints" {
  value = { for i, j in aws_db_instance.AllDBInstances : j.tags_all.Name => j.endpoint }
}

output "db_names" {
  value = { for i, j in aws_db_instance.AllDBInstances : j.tags_all.Name => j.db_name }
}

output "db_usernames" {
  value = { for i, j in aws_db_instance.AllDBInstances : j.tags_all.Name => j.username }
}