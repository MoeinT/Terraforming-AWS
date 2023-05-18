output "instance_ids" {
  value = { for i, j in aws_instance.AllInstances : j.tags_all.Name => j.id }
}