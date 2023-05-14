output "loadBalancer_ids" {
  value = { for i, j in aws_lb.allLoadBalancers : j.tags_all.Name => j.id }
}