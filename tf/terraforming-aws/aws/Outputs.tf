output "con-info" {
  value = join(":", [docker_container.NodeRedContainer.network_data[0].ip_address, docker_container.NodeRedContainer.ports[0].external])
}