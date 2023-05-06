output "subnet-ids" {
  value = { for i, j in aws_subnet.allSubnets : j.tags_all.Name => j.id }
}