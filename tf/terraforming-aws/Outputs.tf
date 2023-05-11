output "vpc-id" {
  value = module.aws.vpc-id
}

output "subnet-ids" {
  value = module.aws.subnet-ids
}

output "gateway-ids" {
  value = module.aws.gateway-ids
}

output "routingtable-ids" {
  value = module.aws.routingtable-ids
}

output "default-rt-id" {
  value = module.aws.default-rt-id
}

output "DBSubnetGroup_names" {
  value = module.aws.DBSubnetGroup_names
}

output "SecurityGroup_ids" {
  value = module.aws.SecurityGroup_ids
}