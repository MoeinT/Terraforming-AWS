output "vpc-ids" {
  value = [for i in aws_vpc.AllVPCs[*] : i]
}