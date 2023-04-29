# Pulling the Node Red Image from Docker Hub
resource "docker_image" "NodeRedImage" {
  name = "nodered/node-red:latest"
}

# Create a Docker Container
/* resource "docker_container" "NodeRedContainer" {
  name  = "noderedcontainer"
  image = docker_image.NodeRedImage.image_id
  ports {
    internal = 1880
    external = 1880
  }
} */