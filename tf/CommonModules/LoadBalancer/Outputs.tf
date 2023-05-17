output "loadBalancer_ids" {
  value = { for i, j in aws_lb.allLoadBalancers : j.tags_all.Name => j.id }
}

output "loadBalancer_arn" {
  value = { for i, j in aws_lb.allLoadBalancers : j.tags_all.Name => j.arn }
}