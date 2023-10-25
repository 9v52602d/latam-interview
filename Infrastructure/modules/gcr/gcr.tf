resource "google_container_registry_repository" "docker_repository" {
  name = var.grc_repo_name
}
