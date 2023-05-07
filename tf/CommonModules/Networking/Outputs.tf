output "vpc-ids" {
  value = { for i, j in aws_vpc.AllVPCs : j.tags_all.Name => j.id }
}

output "default-rt-id" {
  value = { for i, j in aws_default_route_table.default_rt : j.tags_all.Name => j.default_route_table_id }
}