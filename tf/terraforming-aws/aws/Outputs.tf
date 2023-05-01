output "test" {
  value = module.VPCs.vpc-ids[0].vpc-01.id
}