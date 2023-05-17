output "Listener_ids" {
  value = { for i, j in aws_lb_listener.AllListeners : j.tags_all.Name => j.id }
}