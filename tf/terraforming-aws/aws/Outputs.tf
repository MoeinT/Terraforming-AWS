output "vpc-id" {
  value = module.VPCs.vpc-ids["vpc-01"]
}

output "subnet-ids" {
  value = module.Subnets.subnet-ids
}