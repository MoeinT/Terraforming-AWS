output "vpc-id" {
  value = module.VPCs.vpc-ids["vpc-01"]
}

output "subnet-ids" {
  value = module.Subnets.subnet-ids
}

output "gateway-ids" {
  value = module.InternetGateway.internetGateway-ids["gateway-01"]
}

output "routingtable-ids" {
  value = module.RoutingTables.routingTable-ids
}

output "default-rt-id" {
  value = module.VPCs.default-rt-id
}

output "DBSubnetGroup_ids" {
  value = module.DBSubnetGroup.DBSubnetGroup_ids
}

output "DBSubnetGroup_names" {
  value = module.DBSubnetGroup.DBSubnetGroup_names
}

output "SecurityGroup_ids" {
  value = module.SecurityGroups.SecurityGroup_ids
}