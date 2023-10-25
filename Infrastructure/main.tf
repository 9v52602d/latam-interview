module "gcr" {
  source = "./modules/gcr"
  grc_repo_name = "latam-app"
}

module "app" {
  source = "./modules/app"
  project_id = "latam-app"
  dataset_id = "latam-app-dataset"
  service_name = "latam-app-service"
  grc_repository_url = module.gcr.grc_repository_url
}