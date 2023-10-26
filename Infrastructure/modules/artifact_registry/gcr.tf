resource "google_artifact_registry_repository" "docker_repository" {
  location      = "us-central1"
  repository_id =  var.grc_repo_name
  description   = "docker repository"
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }
}