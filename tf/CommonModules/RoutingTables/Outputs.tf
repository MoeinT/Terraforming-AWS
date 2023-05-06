output "routingTable-ids" {
  value = { for i, j in aws_route_table.allRoutingTables : j.tags_all.Name => j.id }
}