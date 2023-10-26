module "artifact_registry" {
  source = "./modules/artifact_registry"
  grc_repo_name = "latam-app"
}

module "app" {
  depends_on = [ 
    module.artifact_registry 
  ]

  source = "./modules/app"
  project_id = "latam"
  dataset_id = "latam-app-dataset"
  service_name = "latam-app-service"
  grc_repository_url = "gcr.io/latam/latam-app/latam-app"
  service_tag = "latest"
  }