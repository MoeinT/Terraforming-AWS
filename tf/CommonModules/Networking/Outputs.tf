output "vpc-ids" {
  value = {for i, j in aws_vpc.AllVPCs : j.tags_all.Name => j.id}
}