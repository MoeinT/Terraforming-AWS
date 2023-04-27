# Pulling the Node Red Image from Docker Hub
resource "docker_image" "NodeRedImage" {
  name = "nodered/node-red:latest"
}