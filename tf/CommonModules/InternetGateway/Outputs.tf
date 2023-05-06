output "internetGateway-ids" {
  value = { for i, j in aws_internet_gateway.allInternetGateways : j.tags_all.Name => j.id }
}